//
//  NotificationVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 10/08/21.
//

import UIKit

class NotificationVC: BaseVC {
    
    @IBOutlet weak var tblNotification: UITableView!
    
    var arrNotification = [NotificationDatum]()
    var notificationModelClass = NotificationModelClass()
    
    //Pagination
    var CurrentPage = 1
    var isApiProcessing = false
    var isStopPaging = false
    
    //Shimmer
    var isTblReload = false
    
    var isLoading = true {
        didSet {
            self.tblNotification.isUserInteractionEnabled = !isLoading
            self.tblNotification.reloadData()
        }
    }
    
    //Pull to refresh
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    func prepareView(){
        self.registerNib()
        self.setupUI()
        self.setupData()
        self.addRefreshControl()
    }
    
    func setupUI(){
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Notifications", leftImage: "Back", rightImages: [], isTranslucent: true)
        self.tblNotification.delegate = self
        self.tblNotification.dataSource = self
    }
    
    func setupData(){
        self.callNotificationListAPI()
    }
    
    func registerNib(){
        let nib = UINib(nibName: NotificationCell.className, bundle: nil)
        self.tblNotification.register(nib, forCellReuseIdentifier: NotificationCell.className)
        let nib1 = UINib(nibName: NotiShimmerCell.className, bundle: nil)
        self.tblNotification.register(nib1, forCellReuseIdentifier: NotiShimmerCell.className)
        let nib2 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblNotification.register(nib2, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = UIColor.init(hexString: "#1F79CD")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblNotification.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.arrNotification = []
        self.isTblReload = false
        self.isLoading = true
        
        self.CurrentPage = 1
        self.isStopPaging = false
        self.callNotificationListAPI()
    }
    
    func reloadData(){
        self.tblNotification.reloadData()
    }
    
}
//MARK:- UITableView Methods
extension NotificationVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrNotification.count > 0 {
            return self.arrNotification.count
        } else {
            return (!self.isTblReload) ? 10 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblNotification.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        cell.selectionStyle = .none
        if(!self.isTblReload){
            let cell = self.tblNotification.dequeueReusableCell(withIdentifier: NotiShimmerCell.className) as! NotiShimmerCell
            cell.lblNoti.text = "Your Order #1234 has been suc..."
            return cell
        }else{
            if(self.arrNotification.count > 0){
                cell.imgNotification.image = UIImage(named: "imgGreenRight")
                cell.lblNotification.text = arrNotification[indexPath.row].notificationMessage ?? ""
                return cell
            }else{
                let NoDatacell = self.tblNotification.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                NoDatacell.lblNoDataTitle.text = "No notification available"
                return NoDatacell
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!self.isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrNotification.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblNotification.contentOffset.y >= (self.tblNotification.contentSize.height - self.tblNotification.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            self.CurrentPage += 1
            self.callNotificationListAPI()
        }
    }
    
}

//MARK:- Api Calls
extension NotificationVC{
    
    func callNotificationListAPI(){
        self.notificationModelClass.notificationVC = self
        let NotificationReqModel = NotificationReqModel()
        NotificationReqModel.page = "\(self.CurrentPage)"
        self.notificationModelClass.webserviceNotificationListAPI(reqModel: NotificationReqModel)
    }
}
