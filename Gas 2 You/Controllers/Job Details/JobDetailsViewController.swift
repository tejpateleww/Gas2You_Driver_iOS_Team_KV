//
//  JobDetailsViewController.swift
//  SideMenuDemo
//
//  Created by Apple on 12/08/21.
//

import UIKit
import GoogleMaps

enum StartJobButtonTitle {
    case StartJob
    case FilledUp
    case CompleteJob
    case JobCompleted
    
    var Name:String {
        switch self {
        case .StartJob:
            return "Start Job"
        case .FilledUp:
            return "Filled Up"
        case .CompleteJob:
            return "Complete Job"
        case .JobCompleted :
            return "Job Completed"
        }
    }
}

enum isFromHome {
    case Request
    case InProcess
    
    var isFrom : String{
        switch self{
        case .InProcess:
            return "InProcess"
        case .Request:
            return "Request"
        }
    }
}

class JobDetailsViewController: BaseVC {
    
    var orderStaus = ""
    var jobViewModel = JobViewModel()
    var path = GMSPath()
    var polyline : GMSPolyline!
    
    // MARK: - --------- Variables ---------
    var isfrom = isFromHome.Request
    var price = ""
    var isfromhome = true
    var isFromStartJob = false
    var strTitle = ""
    var BookingDetail : RequestBookingListDatum?
    var CompBookingDetail : OrderComplateDatum?
    
    var PickLocLong:String = "0.0"
    var PickLocLat:String = "0.0"
    var CurrentLocLat:String = "0.0"
    var CurrentLocLong:String = "0.0"
    var CurrentLocMarker: GMSMarker?
    var DropLocMarker: GMSMarker?
    var arrMarkers: [GMSMarker] = []
    
    // MARK: - --------- IBOutlets ---------
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var LblFilledGallon: themeLabel!
    @IBOutlet weak var ViewFilledGallon: UIView!
    @IBOutlet weak var stackUpdateStatus: UIStackView!
    @IBOutlet weak var lblplateNumberDashLineHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCompleted: UIImageView!
    @IBOutlet weak var LblCompleted: themeLabel!
    @IBOutlet weak var LblDateTime: themeLabel!
    @IBOutlet weak var ViewDateTime: UIView!
    @IBOutlet weak var vwStartJob: UIView!
    @IBOutlet weak var vwChatCall: UIView!
    @IBOutlet weak var stackStatus: UIStackView!
    @IBOutlet weak var btnDownload: ThemeButton!
    @IBOutlet weak var vwUpdateStatus: UIView!
    @IBOutlet weak var BtnStartJob: ThemeButton!
    @IBOutlet weak var ImgViewOntheway: UIImageView!
    @IBOutlet weak var vwGasPriceDetail: UIView!
    @IBOutlet weak var stackItem: UIStackView!
    @IBOutlet weak var btnJobDone: UIButton!
    @IBOutlet weak var stackJobDetails: UIStackView!
    @IBOutlet weak var ImgViewJobDone: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var lblFuelType: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblCarName: themeLabel!
    @IBOutlet weak var lblColor: themeLabel!
    @IBOutlet weak var lblPlateNumber: themeLabel!
    @IBOutlet weak var btnReCenter: UIButton!
    
    
    // MARK: - --------- Life-cycle Methods ---------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: strTitle == "" ? "Job Details" : strTitle, leftImage: "Back", rightImages: [], isTranslucent: true)
        self.setupData()
        self.prepareView()
        
        if(self.isfromhome){
            self.setupMap()
        }else{
            self.setupMapForCompletedOrder()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - --------- Custom Methods ---------
    func prepareView() {
        self.lblcompltedSetup()
        self.ViewDateTime.isHidden = false
        self.mapView.delegate = self
        
        if self.isfromhome{
            switch self.isfrom {
            case .InProcess:
                print("remove this..")
            case .Request:
                self.isFromRequest()
            }
        }else{
            self.isFromMyOrders()
        }
    }
    
    func lblcompltedSetup() {
        self.LblCompleted.transform = CGAffineTransform(rotationAngle: -.pi/4)
    }
    
    func setupMapForCompletedOrder(){
        self.mapView.clear()
        self.path = GMSPath()
        self.polyline = GMSPolyline()
  
        self.PickLocLat = self.BookingDetail?.latitude ?? "0.0"
        self.PickLocLong = self.BookingDetail?.longitude ?? "0.0"
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.PickLocLat) ?? 0.0, longitude:  Double(self.PickLocLong) ?? 0.0, zoom: 13.6)
        self.mapView.camera = camera
        
        //Current Location pin setup
        self.DropLocMarker = GMSMarker()
        self.DropLocMarker?.position = CLLocationCoordinate2D(latitude: Double(self.PickLocLat) ?? 0.0, longitude: Double(self.PickLocLong) ?? 0.0)
        self.DropLocMarker?.snippet = "Your Location"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "IC_pinImg")
        markerView2.layoutSubviews()
        
        self.DropLocMarker?.iconView = markerView2
        self.DropLocMarker?.map = self.mapView
        //self.mapView.selectedMarker = self.DropLocMarker
    }
    
    func setupMap(){
        self.mapView.clear()
        
        self.CurrentLocLat = String(appDel.locationService.currentLocation?.coordinate.latitude ?? 0.0)
        self.CurrentLocLong = String(appDel.locationService.currentLocation?.coordinate.longitude ?? 0.0)
        self.PickLocLat = self.BookingDetail?.latitude ?? "0.0"
        self.PickLocLong = self.BookingDetail?.longitude ?? "0.0"
        
        self.MapSetup(currentlat: CurrentLocLat, currentlong: CurrentLocLong, droplat: PickLocLat, droplog: PickLocLong)
        
    }
    
    func MapSetup(currentlat: String, currentlong:String, droplat: String, droplog:String)
    {
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(currentlat) ?? 0.0, longitude:  Double(currentlong) ?? 0.0, zoom: 13.8)
        self.mapView.camera = camera
        
        //Drop Location pin setup
        self.DropLocMarker = GMSMarker()
        self.DropLocMarker?.position = CLLocationCoordinate2D(latitude: Double(droplat) ?? 0.0, longitude: Double(droplog) ?? 0.0)
        self.DropLocMarker?.snippet = self.BookingDetail?.parkingLocation ?? "Parking Location"
        
        let markerView = MarkerPinView()
        markerView.markerImage = UIImage(named: "IC_pinImg")
        markerView.layoutSubviews()
        
        self.DropLocMarker?.iconView = markerView
        self.DropLocMarker?.map = self.mapView
        
        //Current Location pin setup
        self.CurrentLocMarker = GMSMarker()
        self.CurrentLocMarker?.position = CLLocationCoordinate2D(latitude: Double(currentlat) ?? 0.0, longitude: Double(currentlong) ?? 0.0)
        self.CurrentLocMarker?.snippet = "You"
        
        let markerView2 = MarkerPinView()
        markerView2.markerImage = UIImage(named: "MyLoc")
        markerView2.layoutSubviews()
        
        self.CurrentLocMarker?.iconView = markerView2
        self.CurrentLocMarker?.map = self.mapView
        self.mapView.selectedMarker = self.CurrentLocMarker
        
        //For Displaying both markers in screen centered
        self.arrMarkers.append(self.CurrentLocMarker!)
        self.arrMarkers.append(self.DropLocMarker!)
        var bounds = GMSCoordinateBounds()
        for marker in self.arrMarkers
        {
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 30)
        self.mapView.animate(with: update)
        
        self.fetchRoute(currentlat: currentlat, currentlong: currentlong, droplat: droplat, droplog: droplog)
    }
    
    func fetchRoute(currentlat: String, currentlong:String, droplat: String, droplog:String) {
        
        let CurrentLatLong = "\(currentlat),\(currentlong)"
        let DestinationLatLong = "\(droplat),\(droplog)"
        let param = "origin=\(CurrentLatLong)&destination=\(DestinationLatLong)&mode=driving&key=\(AppInfo.Google_API_Key)"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?\(param)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]?, let jsonResponse = jsonResult else {
                print("error in JSONSerialization")
                return
            }
            
            guard let status = jsonResponse["status"] as? String else {
                return
            }
            
            if(status == "REQUEST_DENIED"){
                print("Map Error : \(jsonResponse["error_message"] as? String ?? "REQUEST_DENIED")")
                return
            }
            
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            
            guard let route = routes[0] as? [String: Any] else {
                return
            }
            
            guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                return
            }
            
            guard let polyLineString = overview_polyline["points"] as? String else {
                return
            }
            
            //Call this method to draw path on map
            self.drawPath(from: polyLineString)
        })
        task.resume()
    }
    
    func drawPath(from polyStr: String){
        self.path = GMSPath(fromEncodedPath: polyStr)!
        self.polyline = GMSPolyline(path: self.path)
        self.polyline.strokeWidth = 3.0
        self.polyline.strokeColor = UIColor.init(hexString: "#faa421")
        self.polyline.map = self.mapView
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupData() {
        if(self.orderStaus == ""){
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        self.lblFuelType.text = self.BookingDetail?.mainServiceName ?? ""
        self.lblAddress.text = self.BookingDetail?.parkingLocation ?? ""
        self.lblColor.text = "Color : \(self.BookingDetail?.colorName ?? "")"
        self.LblDateTime.text = "\(self.BookingDetail?.date ?? "") \n \(self.BookingDetail?.time ?? "")"
        let VehicleName = "\(self.BookingDetail?.makeName ?? "")" + " (" + "\(self.BookingDetail?.plateNumber ?? "")" + ")"
        self.lblCarName.text = VehicleName
        let PlateNumber = self.BookingDetail?.plateNumber ?? ""
        self.lblPlateNumber.text = "Plate Number : \(PlateNumber)"
        
        if(self.orderStaus == "In Progress"){
            self.setupInProcessOrderFlow()
        }else if(self.orderStaus == "Start Job"){
            self.setupInProcessOrderFlow()
        }
    }
    
    // MARK: - --------- InProcessOrderFlow Methods ---------
    func setupInProcessOrderFlow(){
        self.vwGasPriceDetail.isHidden = true
        self.stackItem.isHidden = true
        self.btnJobDone.isHidden = true
        self.ViewDateTime.isHidden = false
        self.btnJobDone.isHidden = false
        self.LblFilledGallon.text = ""
        
        self.BtnStartJob.setTitle(StartJobButtonTitle.FilledUp.Name, for: .normal)
        self.BtnStartJob.isUserInteractionEnabled = false
        self.ImgViewOntheway.image = UIImage(named: "ic_checkBoxSelected")
        
        if(self.orderStaus == "Start Job"){
            
        }else{
            self.callOrderStatusUpdateAPI(strStatus: "Start Job")
        }
    }
    
    // MARK: - --------- IBAction Methods ---------
    @IBAction func btnDownloadTap(_ sender: Any) {
        
    }
    
    @IBAction func BtnStartJob(_ sender: ThemeButton) {
        if(self.orderStaus == "Start Job"){
            self.callOrderCompAPI()
        }else{
            
        }
    }
    
    @IBAction func btnJobDoneTap(_ sender: UIButton) {
        if(self.LblFilledGallon.text != nil || self.LblFilledGallon.text != ""){
            let Gallon: String = self.LblFilledGallon.text ?? ""
            let words = Gallon.components(separatedBy: " ")
            self.JobDoneTapped(strGallon : words[0])
        }
        self.JobDoneTapped(strGallon :"")
    }
    
    @IBAction func btnChatTap(_ sender: Any) {
        let vc : ChatListVC = ChatListVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCallTap(_ sender: Any) {
        guard let number = URL(string: "tel://" + "\(self.BookingDetail?.customerContactNumber ?? "")") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func btnReCenterAction(_ sender: Any) {
        if(self.isfromhome){
            let camera = GMSCameraPosition.camera(withLatitude: Double(self.CurrentLocLat) ?? 0.0, longitude:  Double(self.CurrentLocLong) ?? 0.0, zoom: 17.5)
            self.mapView.animate(to: camera)
        }else{
            let camera = GMSCameraPosition.camera(withLatitude: Double(self.BookingDetail?.latitude ?? "0.0") ?? 0.0, longitude:  Double(self.BookingDetail?.longitude ?? "0.0") ?? 0.0, zoom: 17.5)
            self.mapView.animate(to: camera)
        }
    }
    
}

// MARK: - --------- Extension Methods ---------
extension JobDetailsViewController{
    func isfromHome(sender : UIButton) {
        switch isfrom{
        case .InProcess:
            isFromInProcess(sender: sender)
        case .Request :
            isFromRequest()
        }
    }
    
    func isFromMyOrders(){
        self.vwUpdateStatus.isHidden = false
        self.stackUpdateStatus.isHidden = true
        self.BtnStartJob.isHidden = true
        self.lblLine.isHidden = false
        self.btnDownload.isHidden = false
        self.vwChatCall.isHidden = true
        self.lblplateNumberDashLineHeight.constant = 0
        self.stackItem.isHidden = false
        self.vwGasPriceDetail.isHidden = false
        self.imgCompleted.isHidden = false
        self.LblCompleted.isHidden = false
        self.stackStatus.isHidden = true
    }
    
    func isFromInProcess(sender : UIButton){
        if sender.titleLabel?.text == StartJobButtonTitle.StartJob.Name {
            
        } else if sender.titleLabel?.text == StartJobButtonTitle.FilledUp.Name {
            ViewDateTime.isHidden = false
            ViewFilledGallon.isHidden = false
        } else if sender.titleLabel?.text == StartJobButtonTitle.CompleteJob.Name {
            
        }
    }
    
    func isFromRequest(){
        vwStartJob.isHidden = true
        vwChatCall.isHidden = true
        vwUpdateStatus.isHidden = true
        vwGasPriceDetail.isHidden = true
        stackItem.isHidden = true
    }
    
    func JobDoneTapped(strGallon : String){
        let vc : EnterQuentityVC = EnterQuentityVC.instantiate(fromAppStoryboard: .Main)
        vc.btnSubmitClosure = { name in
            self.ViewFilledGallon.isHidden = false
            self.LblFilledGallon.text = name
            self.ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            self.BtnStartJob.setTitle(StartJobButtonTitle.CompleteJob.Name, for: .normal)
            self.BtnStartJob.isUserInteractionEnabled = true
            self.orderStaus = (self.orderStaus == "Start Job") ? self.orderStaus : "Start Job"
        }
        vc.Quantity = self.LblFilledGallon.text ?? ""
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func JobCompleted(){
        let vc : SendInvoiceVC = SendInvoiceVC.instantiate(fromAppStoryboard: .Main)
        vc.modalPresentationStyle = .overFullScreen
        vc.BookingDetail = self.CompBookingDetail
        vc.btnSubmitTapClosure = {
            NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil)
            self.navigationController?.popToRootViewController(animated: false)
        }
        self.present(vc, animated: false, completion: nil)
    }
}

// MARK: - --------- GMSMapViewDelegate ---------
extension JobDetailsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let view = MarkerInfoWindowView()
        view.titleLabel.numberOfLines = 0
        
        if(marker == self.CurrentLocMarker){
            view.titleLabel.text = "You"
            view.titleLabel.textAlignment = .center
            view.imgArrow.isHidden = true
            view.frame.size.width = view.titleLabel.intrinsicContentSize.width + 45
            view.frame.size.height = view.titleLabel.bounds.size.height - 15
            view.sizeToFit()
        }else{
            view.titleLabel.text = self.BookingDetail?.parkingLocation ?? "Parking Location"
            view.titleLabel.textAlignment = .left
            view.imgArrow.isHidden = false
            view.frame.size.width = UIScreen.main.bounds.size.width - 100
            view.frame.size.height = view.titleLabel.bounds.size.height + 30
            view.sizeToFit()
        }
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
}

//MARK:- Api Calls
extension JobDetailsViewController{
    
    func callOrderStatusUpdateAPI(strStatus : String){
        self.jobViewModel.JobDetailsVC = self
        
        let JobStatus = JobStatusUpdateReqModel()
        JobStatus.orderId = self.BookingDetail?.id ?? ""
        JobStatus.orderStatus = strStatus
        
        self.jobViewModel.webserviceOrderStatusUpdateAPI(reqModel: JobStatus)
    }
    
    func callOrderCompAPI(){
        self.jobViewModel.JobDetailsVC = self
        
        let JobComp = JobCompReqModel()
        JobComp.orderId = self.BookingDetail?.id ?? ""
        JobComp.totalGallon = self.LblFilledGallon.text ?? "0.0"
        JobComp.pricePerGallon = self.BookingDetail?.price ?? ""
        
        self.jobViewModel.webserviceOrderCompAPI(reqModel: JobComp)
    }
    
}
