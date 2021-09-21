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
    
    // MARK: - --------- Variables ---------
    var isfrom = isFromHome.Request
    var price = ""
    var isfromhome = true
    var isFromStartJob = false
    var strTitle = ""
    var BookingDetail : RequestBookingListDatum?
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
    
    // MARK: - --------- Life-cycle Methods ---------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: strTitle == "" ? "Job Details" : strTitle, leftImage: "Back", rightImages: [], isTranslucent: true)
        self.setupData()
        self.prepareView()
        self.setupMap()
    }
    
    
    // MARK: - --------- Custom Methods ---------
    func prepareView() {
        self.lblcompltedSetup()
        self.ViewDateTime.isHidden = false
        self.mapView.delegate = self
        
        if self.isfromhome{
            switch self.isfrom {
            case .InProcess:
                self.vwGasPriceDetail.isHidden = true
                self.stackItem.isHidden = true
                self.btnJobDone.isHidden = true
                if self.isFromStartJob{
                    self.BtnStartJob(BtnStartJob)
                }
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
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
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
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.init(hexString: "#faa421")
        polyline.map = self.mapView
    }
    
    func setupData() {
        self.lblFuelType.text = self.BookingDetail?.mainServiceName ?? ""
        self.lblAddress.text = self.BookingDetail?.parkingLocation ?? ""
        self.lblColor.text = "Color : \(self.BookingDetail?.colorName ?? "")"
        self.LblDateTime.text = "\(self.BookingDetail?.date ?? "") \n \(self.BookingDetail?.time ?? "")"
        let VehicleName = "\(self.BookingDetail?.makeName ?? "")" + " (" + "\(self.BookingDetail?.plateNumber ?? "")" + ")"
        self.lblCarName.text = VehicleName
        let PlateNumber = self.BookingDetail?.plateNumber ?? ""
        self.lblPlateNumber.text = "Plate Number : \(PlateNumber)"
        
    }
    
    // MARK: - --------- IBAction Methods ---------
    @IBAction func btnDownloadTap(_ sender: Any) {
        
    }
    @IBAction func BtnStartJob(_ sender: ThemeButton) {
        isfromHome(sender: sender)
    }
    @IBAction func btnJobDoneTap(_ sender: UIButton) {
        isFromJobDone()
    }
    @IBAction func btnChatTap(_ sender: Any) {
        let vc : ChatListVC = ChatListVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCallTap(_ sender: Any) {
        guard let number = URL(string: "tel://" + "0123456789") else { return }
        UIApplication.shared.open(number)
    }
    
    // ----------------------------------------------------
    // MARK: - --------- Webservice Methods ---------
    // ----------------------------------------------------
    
}
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
        stackUpdateStatus.isHidden = true
        BtnStartJob.isHidden = true
        lblLine.isHidden = false
        btnDownload.isHidden = false
        vwChatCall.isHidden = true
        lblplateNumberDashLineHeight.constant = 0
        stackItem.isHidden = false
        vwGasPriceDetail.isHidden = false
        imgCompleted.isHidden = false
        LblCompleted.isHidden = false
        stackStatus.isHidden = true
    }
    func isFromInProcess(sender : UIButton){
        if sender.titleLabel?.text == StartJobButtonTitle.StartJob.Name {
            BtnStartJob.setTitle(StartJobButtonTitle.FilledUp.Name, for: .normal)
            ImgViewOntheway.image = UIImage(named: "ic_checkBoxSelected")
            //                  ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            ViewDateTime.isHidden = false
            BtnStartJob.isUserInteractionEnabled = false
            btnJobDone.isHidden = false
        } else if sender.titleLabel?.text == StartJobButtonTitle.FilledUp.Name {
            
            //                  BtnStartJob.setTitle(StartJobButtonTitle.CompleteJob.Name, for: .normal)
            //                  ImgViewOntheway.image = UIImage(named: "ic_checkBoxSelected")
            //                  ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            ViewDateTime.isHidden = false
            //                #imageLiteral(resourceName: "ic_checkBoxSelected")
            ViewFilledGallon.isHidden = false
        } else if sender.titleLabel?.text == StartJobButtonTitle.CompleteJob.Name {
            let vc : SendInvoiceVC = SendInvoiceVC.instantiate(fromAppStoryboard: .Main)
            vc.modalPresentationStyle = .overFullScreen
            vc.btnSubmitTapClosure = {
                //                    let vc : CompletedJobsVC = CompletedJobsVC.instantiate(fromAppStoryboard: .Main)
                //                    self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.popToRootViewController(animated: false)
            }
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    func isFromRequest(){
        vwStartJob.isHidden = true
        vwChatCall.isHidden = true
        vwUpdateStatus.isHidden = true
        vwGasPriceDetail.isHidden = true
        stackItem.isHidden = true
    }
    func isFromJobDone(){
        btnJobDone.isHidden = false
        
        let vc : EnterQuentityVC = EnterQuentityVC.instantiate(fromAppStoryboard: .Main)
        vc.btnSubmitClosure = { name in
            self.ViewFilledGallon.isHidden = false
            self.LblFilledGallon.text = name
            self.ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            self.BtnStartJob.setTitle(StartJobButtonTitle.CompleteJob.Name, for: .normal)
            self.btnJobDone.isHidden = true
            self.BtnStartJob.isUserInteractionEnabled = true
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

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
