//
//  HomeVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit

class HomeVC: BaseVC {
    
    //MARK:- OUTLETS
    @IBOutlet weak var btnRequest: ThemeButton!
    @IBOutlet weak var btnInProgress: themeButton!
    @IBOutlet weak var vwInprogress: UIView!
    @IBOutlet weak var vwRequest: UIView!
    @IBOutlet weak var tblHome: UITableView!
    
    //MARK:- GLOBAL PROPERTIES
    var isInProcess : Bool = false
    var homeViewModel = HomeViewModel()
    var CurrentPage = 1
    var CurrentPageInProgress = 1
    var arrBookings = [RequestBookingListDatum]()
    var isApiProcessing = false
    var isStopPaging = false
    var isSelectedRequest = true
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.registerNib()
        self.callBookingRequestAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK:- Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Home", leftImage: "Menu", rightImages: [], isTranslucent: true)
        self.rightNavBarButton()
        
        self.tblHome.delegate = self
        self.tblHome.dataSource = self
        self.tblHome.isHidden = true
    }
    
    func registerNib(){
        let nib = UINib(nibName: JobsCell.className, bundle: nil)
        self.tblHome.register(nib, forCellReuseIdentifier: JobsCell.className)
        let nib1 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblHome.register(nib1, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func rightNavBarButton(){
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "IC_chat"), for: .normal)
        button.addTarget(self, action:#selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
    }
    
    @objc func callMethod(){
        let vc : ChatListVC = ChatListVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Button ACTIONS
    @IBAction func btnRequestTap(_ sender: UIButton) {
        self.isSelectedRequest = true
        self.CurrentPage = 1
        self.isApiProcessing = false
        self.isStopPaging = false
        
        self.btnRequest.titleLabel?.font = CustomFont.PoppinsBold.returnFont(14)
        self.vwRequest.backgroundColor = UIColor.init(hexString: "#1F79CD")
        self.btnInProgress.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(14)
        self.vwInprogress.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.3)
        self.isInProcess = false
        self.callBookingRequestAPI()
    }
    
    @IBAction func btnInprogressTap(_ sender: UIButton) {
        self.isSelectedRequest = false
        self.CurrentPageInProgress = 1
        self.isApiProcessing = false
        self.isStopPaging = false
        
        self.btnRequest.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(14)
        self.vwRequest.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.3)
        self.btnInProgress.titleLabel?.font = CustomFont.PoppinsBold.returnFont(14)
        self.vwInprogress.backgroundColor = UIColor.init(hexString: "#1F79CD")
        self.isInProcess = true
        self.callBookingInProgressAPI()
        
    }
    
}

//MARK:- UITableview Methods
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrBookings.count > 0 {
            return self.arrBookings.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeueReusableCell(withIdentifier: JobsCell.className) as! JobsCell
        
        if self.arrBookings.count != 0 {
            
            cell.lblFuelType.text = self.arrBookings[indexPath.row].mainServiceName ?? ""
            let VehicleName = "\(self.arrBookings[indexPath.row].makeName ?? "")" + " (" + "\(self.arrBookings[indexPath.row].plateNumber ?? "")" + ")"
            cell.lblVehicle.text = VehicleName
            cell.lblAddress.text = self.arrBookings[indexPath.row].parkingLocation ?? ""
            let DateTime = "\(self.arrBookings[indexPath.row].time ?? "")" + ", " + "\(self.arrBookings[indexPath.row].date ?? "")"
            cell.lblDateAndTime.text = DateTime
            
            cell.stackbtn.isHidden = isInProcess ? false : true
            cell.stackButtomHeight.constant = cell.stackbtn.isHidden ? 0 : 40
            cell.btnReject.isHidden = isInProcess ? true : false
            cell.btnAccept.setTitle(isInProcess ? "START JOB" : "ACCEPT", for: .normal)
            
            cell.btnAcceptTapClosure = {
                HomeVC.showAlertWithTitleFromVC(vc: self, title: "Gas2YouDriver", message: "Are you sure you want to start job ?", buttons: ["Cancel", "OK"]) { index in
                    if index == 1{
                        let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
                        vc.isFromStartJob = true
                        vc.isfrom = .InProcess
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            return cell
            
        }else {
            let NoDatacell = self.tblHome.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
            return NoDatacell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrBookings.count != 0 {
            return UITableView.automaticDimension
        }else{
            return tableView.frame.height
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.isSelectedRequest){
            let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
            vc.isfrom = isInProcess ? isFromHome.InProcess : isFromHome.Request
            vc.strTitle = !isInProcess ? "Request Detail" : ""
            vc.BookingDetail = self.arrBookings[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblHome.contentOffset.y >= (self.tblHome.contentSize.height - self.tblHome.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            if(self.isSelectedRequest == true){
                self.CurrentPage += 1
                self.CurrentPageInProgress = 1
                self.callBookingRequestAPI()
            }else{
                self.CurrentPageInProgress += 1
                self.CurrentPage = 1
                self.callBookingInProgressAPI()
            }
        }
    }
    
}

//MARK:- Api Calls
extension HomeVC{
    
    func callBookingRequestAPI(){
        self.homeViewModel.homeVC = self
        
        let HomeBooking = HomeBookingReqModel()
        HomeBooking.page = "\(self.CurrentPage)"
        
        self.homeViewModel.webserviceBookingRequestAPI(reqModel: HomeBooking)
    }
    
    func callBookingInProgressAPI(){
        self.homeViewModel.homeVC = self
        
        let HomeBooking = HomeBookingReqModel()
        HomeBooking.page = "\(self.CurrentPageInProgress)"
        
        self.homeViewModel.webserviceBookingInProgressAPI(reqModel: HomeBooking)
    }
}
