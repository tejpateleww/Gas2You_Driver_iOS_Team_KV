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

    // ----------------------------------------------------
    // MARK: - --------- Variables ---------
    // ----------------------------------------------------
    
    var isfrom = isFromHome.Request
    var price = ""
    var isfromhome = true
    var isFromStartJob = false
    var strTitle = ""
    
    var locationManager = CLLocationManager()
    // ----------------------------------------------------
    // MARK: - --------- IBOutlets ---------
    // ----------------------------------------------------
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
    // ----------------------------------------------------
    // MARK: - --------- Life-cycle Methods ---------
    // ----------------------------------------------------
    func lblcompltedSetup() {
        LblCompleted.transform = CGAffineTransform(rotationAngle: -.pi/4)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblcompltedSetup()
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: strTitle == "" ? "Job Details" : strTitle, leftImage: "Back", rightImages: [], isTranslucent: true)
        
        setUIMapPin()
        
        ViewDateTime.isHidden = false
//        isfromHome(sender: UIButton)
        if isfromhome{
        switch isfrom {
        case .InProcess:
            vwGasPriceDetail.isHidden = true
//            vwUpdateStatus.isHidden = true
            
            stackItem.isHidden = true
            vwGasPriceDetail.isHidden = true
            btnJobDone.isHidden = true
            if isFromStartJob{
            BtnStartJob(BtnStartJob)
            }
        case .Request:
            self.isFromRequest()
        }
        }else{
            self.isFromMyOrders()
        }
        // Do any additional setup after loading the view.
    }
    
    
    // ----------------------------------------------------
    // MARK: - --------- Custom Methods ---------
    // ----------------------------------------------------
    
    func setUIMapPin() {
        initializeTheLocationManager()
        var position = CLLocationCoordinate2DMake(23.033863,72.585022)
        let marker = GMSMarker(position: position)
        marker.icon = drawImageWithProfilePic(pp: nil, image: #imageLiteral(resourceName: "IC_pinImg"))
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
    }
    
    func drawImageWithProfilePic(pp: UIImage?, image: UIImage) -> UIImage {

        let imgView = UIImageView(image: image)
        let picImgView = UIImageView(image: pp)
        picImgView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        imgView.addSubview(picImgView)
        picImgView.center.x = imgView.center.x
        picImgView.center.y = imgView.center.y - 7
        picImgView.layer.cornerRadius = picImgView.frame.width/2
        picImgView.clipsToBounds = true
        imgView.setNeedsLayout()
        picImgView.setNeedsLayout()

        let newImage = imageWithView(view: imgView)
        return newImage
    }
    
    func imageWithView(view: UIView) -> UIImage {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image ?? UIImage()
    }
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
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


extension JobDetailsViewController: CLLocationManagerDelegate {
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location = locationManager.location?.coordinate
        
        cameraMoveToLocation(toLocation: location)
        
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 4)
        }
    }
    
    
    
}
