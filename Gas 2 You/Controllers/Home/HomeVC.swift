//
//  HomeVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit
import Foundation
import UIView_Shimmer

class HomeVC: BaseVC {
    
    //MARK: - OUTLETS
    @IBOutlet weak var btnRequest: ThemeButton!
    @IBOutlet weak var btnInProgress: themeButton!
    @IBOutlet weak var vwInprogress: UIView!
    @IBOutlet weak var vwRequest: UIView!
    @IBOutlet weak var tblHome: UITableView!
    
    //MARK: - GLOBAL PROPERTIES
    var isInProcess : Bool = false
    var homeViewModel = HomeViewModel()
    var CurrentPage = 1
    var CurrentPageInProgress = 1
    var arrBookings = [RequestBookingListDatum]()
    var isApiProcessing = false
    var isStopPaging = false
    var isSelectedRequest = true
    var pagingSpinner = UIActivityIndicatorView()
    let refreshControl = UIRefreshControl()
    var jobViewModel = JobViewModel()
    
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblHome.isUserInteractionEnabled = !isLoading
            self.tblHome.reloadData()
        }
    }
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkForNotification()
        self.prepareView()
        self.registerNib()
        self.callBookingRequestAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: - Custom methods
    func addNotificationObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadData), name: Notification.Name("ReloadData"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .goToCompletedScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToCompletedScreen), name: .goToCompletedScreen, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .refreshHomeScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(initUrlAndRefreshRequestList), name: .refreshHomeScreen, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .refreshJobInProgressScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(initUrlAndRefreshJobInProgress), name: .refreshJobInProgressScreen, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .goToChatScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToChatScreen), name: .goToChatScreen, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .goToEarningScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToEarningScreen), name: .goToEarningScreen, object: nil)
    }
    
    func checkForNotification(){
        if(AppDelegate.pushNotificationObj != nil){
            if(AppDelegate.pushNotificationType == NotificationTypes.newMessage.rawValue){
                self.goToChatScreen()
            }else if(AppDelegate.pushNotificationType == NotificationTypes.jobComplete.rawValue){
                self.goToCompletedScreen()
            }else if(AppDelegate.pushNotificationType == NotificationTypes.newEarning.rawValue){
                self.goToEarningScreen()
            }else if(AppDelegate.pushNotificationType == NotificationTypes.jobInProgress.rawValue){
                self.initUrlAndRefreshJobInProgress()
            }
        }
    }
    
    @objc func initUrlAndRefreshRequestList() {
        self.refreshNewRequest()
        AppDelegate.pushNotificationType = nil
        AppDelegate.pushNotificationObj = nil
    }
    
    @objc func initUrlAndRefreshJobInProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshInprogresRequest()
        }
        
        AppDelegate.pushNotificationType = nil
        AppDelegate.pushNotificationObj = nil
    }
    
    @objc func ReloadData() {
        self.arrBookings = []
        self.isTblReload = false
        self.isLoading = true
        
        self.CurrentPageInProgress = 1
        self.callBookingInProgressAPI()
    }
    
    @objc func goToCompletedScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let vc : CompletedJobsVC = CompletedJobsVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        AppDelegate.pushNotificationObj = nil
        AppDelegate.pushNotificationType = nil
    }
    
    @objc func goToChatScreen() {
        
        let bookingId =  AppDelegate.pushNotificationObj?.booking_id ?? ""
       
        let vc : ChatViewController = ChatViewController.instantiate(fromAppStoryboard: .Main)
        vc.isFromPush = true
        vc.bookingID = bookingId
        self.navigationController?.pushViewController(vc, animated: true)
        
        AppDelegate.pushNotificationObj = nil
        AppDelegate.pushNotificationType = nil
    }
    
    @objc func goToEarningScreen() {
        
        let vc : MyEarningsVC = MyEarningsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
        
        AppDelegate.pushNotificationObj = nil
        AppDelegate.pushNotificationType = nil
    }
    
    func prepareView(){
        self.isLoading = true
        
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Home", leftImage: "Menu", rightImages: [], isTranslucent: true)
        self.rightNavBarButton()
        
        self.tblHome.delegate = self
        self.tblHome.dataSource = self
        
        self.addNotificationObs()
        self.addTableFooter()
        self.addRefreshControl()
        
    }

    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = UIColor.init(hexString: "#1F79CD")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblHome.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if(isSelectedRequest){
            self.refreshNewRequest()
        }else{
            self.refreshInprogresRequest()
        }
    }
    
    func addTableFooter(){
        if #available(iOS 13.0, *) {
            self.pagingSpinner = UIActivityIndicatorView(style: .medium)
        } else {
            self.pagingSpinner.style = .whiteLarge
        }
        self.pagingSpinner.stopAnimating()
        self.pagingSpinner.color = UIColor.init(hexString: "#1F79CD")
        self.pagingSpinner.hidesWhenStopped = true
        self.tblHome.tableFooterView = self.pagingSpinner
        self.tblHome.tableFooterView?.isHidden = true
    }
    
    func registerNib(){
        let nib = UINib(nibName: JobsCell.className, bundle: nil)
        self.tblHome.register(nib, forCellReuseIdentifier: JobsCell.className)
        let nib1 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblHome.register(nib1, forCellReuseIdentifier: NoDataTableViewCell.className)
        let nib2 = UINib(nibName: ShimmerCell.className, bundle: nil)
        self.tblHome.register(nib2, forCellReuseIdentifier: ShimmerCell.className)
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
    
    func RedirectToJobs(index : IndexPath){
        let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
        vc.isFromStartJob = true
        vc.isfrom = .InProcess
        vc.BookingDetail = self.arrBookings[index.row]
        vc.orderStaus = self.arrBookings[index.row].statusLabel ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshNewRequest(){
        self.arrBookings = []
        self.isTblReload = false
        self.isLoading = true
        
        self.tblHome.tableFooterView?.isHidden = true
        self.pagingSpinner.stopAnimating()
        
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
    
    func refreshInprogresRequest(){
        self.arrBookings = []
        self.isTblReload = false
        self.isLoading = true
        
        self.tblHome.tableFooterView?.isHidden = true
        self.pagingSpinner.stopAnimating()
        
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
    
    //MARK: - Button ACTIONS
    @IBAction func btnRequestTap(_ sender: UIButton) {
        self.refreshNewRequest()
    }
    
    @IBAction func btnInprogressTap(_ sender: UIButton) {
        self.refreshInprogresRequest()
    }
    
}

//MARK: - UITableview Methods
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrBookings.count > 0 {
            return self.arrBookings.count
        } else {
            return (!self.isTblReload) ? 10 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(!isTblReload){
            let cell = tblHome.dequeueReusableCell(withIdentifier: ShimmerCell.className) as! ShimmerCell
            cell.lblFuelType.text = "Fill-ups"
            cell.lblVehicle.text = "Suzuki (GJ 21 HG 2121)"
            cell.lblAddress.text = "iSquare, Shukan Cross Road, Science City Rd, Sola, Ahmedabad, Gujarat"
            cell.lblDateAndTime.text = "2021-10-01 07:07:06"
            return cell
        }else{
            let cell = tblHome.dequeueReusableCell(withIdentifier: JobsCell.className) as! JobsCell
            if self.arrBookings.count != 0 {
                
                cell.lblFuelType.text = self.arrBookings[indexPath.row].mainServiceName ?? ""
                let VehicleName = "\(self.arrBookings[indexPath.row].makeName ?? "")" + " (" + "\(self.arrBookings[indexPath.row].plateNumber ?? "")" + ")"
                cell.lblVehicle.text = VehicleName
                cell.lblAddress.text = self.arrBookings[indexPath.row].parkingLocation ?? ""
                let DateTime = "\(self.arrBookings[indexPath.row].time ?? "")" + ", " + "\(self.arrBookings[indexPath.row].date ?? "")"
                cell.lblDateAndTime.text = DateTime
                
                cell.stackbtn.isHidden = isInProcess ? false : true
                cell.stackButtomHeight.constant = cell.stackbtn.isHidden ? 0 : 45
                cell.btnReject.isHidden = isInProcess ? true : false
                cell.btnAccept.setTitle(isInProcess ? self.arrBookings[indexPath.row].statusLabel ?? "IN PROGRESS" : "ACCEPT", for: .normal)
                
                cell.btnAcceptTapClosure = {
                    if(self.arrBookings[indexPath.row].statusLabel == "In Progress"){
                        self.RedirectToJobs(index: indexPath)
                    }else{
                        HomeVC.showAlertWithTitleFromVC(vc: self, title: "Gas2YouDriver", message: "Are you sure you want to start job ?", buttons: ["Cancel", "OK"]) { index in
                            if index == 1{
                                //self.RedirectToJobs(index: indexPath)
                                self.callOrderStatusUpdateAPI(strStatus: "In Progress", obj: self.arrBookings[indexPath.row], index: indexPath)
                            }
                        }
                    }
                }
                return cell
                
            }else {
                let NoDatacell = self.tblHome.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                if(self.isSelectedRequest){
                    if #available(iOS 13.0, *) {
                        NoDatacell.imgNoData.image = UIImage(named: "ic_MyOrders")?.withTintColor(UIColor.init(hexString: "#1F79CD"))
                    } else {
                        NoDatacell.imgNoData.image =  UIImage(named: "ic_MyOrders")?.withRenderingMode(.alwaysTemplate)
                        NoDatacell.imgNoData.tintColor = UIColor.init(hexString: "#1F79CD")
                    }
                    NoDatacell.lblNoDataTitle.text = "No upcoming order available"
                }else{
                    if #available(iOS 13.0, *) {
                        NoDatacell.imgNoData.image = UIImage(named: "ic_MyOrders")?.withTintColor(UIColor.init(hexString: "#1F79CD"))
                    } else {
                        NoDatacell.imgNoData.image =  UIImage(named: "ic_MyOrders")?.withRenderingMode(.alwaysTemplate)
                        NoDatacell.imgNoData.tintColor = UIColor.init(hexString: "#1F79CD")
                    }
                    NoDatacell.lblNoDataTitle.text = "No in-progress order available"
                }
                return NoDatacell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrBookings.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.arrBookings.count > 0){
            if(self.arrBookings[indexPath.row].orderStatus == "In Progress"){
                self.RedirectToJobs(index: indexPath)
            }else{
                let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
                vc.isfrom = (self.arrBookings[indexPath.row].orderStatus == "In Progress") ? isFromHome.InProcess : isFromHome.Request //isInProcess ? isFromHome.InProcess : isFromHome.Request
                vc.strTitle = !isInProcess ? "Request Detail" : ""
                vc.BookingDetail = self.arrBookings[indexPath.row]
                vc.orderStaus = "Pending"
                self.navigationController?.pushViewController(vc, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblHome.contentOffset.y >= (self.tblHome.contentSize.height - self.tblHome.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            if(self.isSelectedRequest){
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

//MARK: - Api Calls
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
    
    func callOrderStatusUpdateAPI(strStatus : String, obj:RequestBookingListDatum?, index : IndexPath){
        self.jobViewModel.homeVC = self
        
        let JobStatus = JobStatusUpdateReqModel()
        JobStatus.orderId = obj?.id ?? ""
        JobStatus.orderStatus = strStatus
        
        self.jobViewModel.webserviceOrderStatusUpdateFromHomeAPI(reqModel: JobStatus, indexpath: index)
    }
}
