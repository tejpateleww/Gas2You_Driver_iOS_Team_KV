//
//  MyEarningsVC.swift
//  Gas 2 You
//
//  Created by Harsh on 09/08/21.
//

import UIKit

class MyEarningsVC: BaseVC {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblTotalEarningsPrice: themeLabel!
    @IBOutlet weak var lblTotalEarnings: themeLabel!
    @IBOutlet weak var lblHistory: themeLabel!
    @IBOutlet weak var tblMyEarnings: UITableView!
    @IBOutlet weak var tblMyEarningsHeight: NSLayoutConstraint!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var vwTotalEarning: UIView!
    @IBOutlet weak var scrollVw: UIScrollView!
    
    //MARK: - Variables And Properties:-
    var earningViewModel = EarningViewModel()
    var arrEarning : [EarningResDatum] = []
    let refreshControl = UIRefreshControl()
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblMyEarnings.isUserInteractionEnabled = !isLoading
            self.tblMyEarnings.reloadData()
        }
    }
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        appDel.isEarningScreen = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        appDel.isEarningScreen = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblMyEarnings.layer.removeAllAnimations()
        self.tblMyEarningsHeight.constant = self.tblMyEarnings.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    //MARK: - Custom Methods
    func prepareView(){
        self.registerNib()
        self.addRefreshControl()
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "My Earnings", leftImage: "Back", rightImages: [], isTranslucent: true)
        
        self.tblMyEarnings.delegate = self
        self.tblMyEarnings.dataSource = self
        self.tblMyEarnings.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.tblMyEarnings.separatorStyle = .none
        
        self.vwTotalEarning.addGeneralShaddow()
        self.vwTotalEarning.layer.cornerRadius = 9
        self.imgBackground.layer.cornerRadius = 9
        
        NotificationCenter.default.removeObserver(self, name: .refreshEarningScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadData), name: .refreshEarningScreen, object: nil)
        
        self.callEArningListApi()
    }
    
    @objc func ReloadData() {
        self.isLoading = true
        self.isTblReload = false
        self.callEArningListApi()
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = UIColor.init(hexString: "#1F79CD")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblMyEarnings.addSubview(self.refreshControl)
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        self.arrEarning = []
        self.isTblReload = false
        self.isLoading = true
        self.callEArningListApi()
    }
    
    func registerNib(){
        let nib = UINib(nibName: MyEarningsCell.className, bundle: nil)
        self.tblMyEarnings.register(nib, forCellReuseIdentifier: MyEarningsCell.className)
        
        let nib2 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblMyEarnings.register(nib2, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
}

//MARK: - UITableView Delegate and Data Sourse Methods
extension MyEarningsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrEarning.count > 0 {
            return self.arrEarning.count
        } else {
            return (!self.isTblReload) ? (UIDevice.current.userInterfaceIdiom == .phone) ? 5 : 10 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblMyEarnings.dequeueReusableCell(withIdentifier: MyEarningsCell.className) as! MyEarningsCell
        if(!self.isTblReload){
            cell.lblPaymentDone.text = "Payment Done"
            cell.lblAmount.text = "123 Hello 123"
            cell.lblDate.text = "06:58 AM"
            return cell
        }else{
            if(self.arrEarning.count > 0){
                
                cell.lblAmount.text = "$\(self.arrEarning[indexPath.row].amount ?? "0")"
                cell.lblDate.text = self.arrEarning[indexPath.row].date
                return cell
            }else{
                let NoDatacell = self.tblMyEarnings.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                NoDatacell.lblNoDataTitle.text = "Earnings not found."
                return NoDatacell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!self.isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrEarning.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
    }
    
}

//MARK: - API call
extension MyEarningsVC {
    func callEArningListApi(){
        self.earningViewModel.myEarningsVC = self
        
        let reqModel = EarningReqModel()
        self.earningViewModel.webserviceEarningListAPI(reqModel: reqModel)
    }
}

