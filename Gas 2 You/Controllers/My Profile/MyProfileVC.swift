//
//  MyProfileVC.swift
//  Gas 2 You
//
//  Created by MacMini on 10/08/21.
//

import UIKit
import SDWebImage
import Photos

class MyProfileVC: BaseVC {
    
    // MARK: - --------- Outlets ---------
    @IBOutlet weak var btnChangePassword: ThemeButton!
    @IBOutlet weak var btnEditProfileTap: ThemeButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtPhone: themeTextfield!
    @IBOutlet weak var vwProfile: UIView!
    @IBOutlet weak var btnSave: ThemeButton!
    @IBOutlet weak var lblRating: themeLabel!
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"
    var imagePicker = UIImagePickerController()
    var userInfoViewModel = UserInfoViewModel()
    
    // MARK: - --------- Life-cycle Methods ---------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: "My Profile", leftImage: "Back", rightImages: [], isTranslucent: true)
        self.prepareView()
    }
    
    // MARK: - --------- Custom methods ---------
    func prepareView(){
        self.imagePicker.delegate = self
        self.setupUI()
        self.setupDate()
    }
    
    func setupUI(){
        
        self.vwProfile.layer.cornerRadius = self.vwProfile.frame.height/2
        self.vwProfile.addShadow()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        
        self.btnChangePassword.layer.cornerRadius = 9
        self.btnChangePassword.layer.borderWidth = 2
        self.btnChangePassword.layer.borderColor = UIColor.init(hexString: "#1C75BB").cgColor
        self.btnChangePassword.backgroundColor = .white
        
        self.btnEditProfileTap.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.4588235294, blue: 0.7333333333, alpha: 0.19)
        self.btnEditProfileTap.layer.cornerRadius = self.btnEditProfileTap.frame.height/2
        self.btnEditProfileTap.layer.borderWidth = 2
        self.btnEditProfileTap.layer.borderColor = UIColor.init(hexString: "#1C75BB").cgColor
        
        self.txtName.fontColor = .black
        self.txtEmail.fontColor = .black
        self.txtPhone.fontColor = .black
        
        self.txtEmail.isUserInteractionEnabled = false
        self.txtPhone.isUserInteractionEnabled = false
    }
    
    func setupDate(){
        let obj = Singleton.sharedInstance.UserProfilData
        self.txtName.text = obj?.fullName ?? ""
        self.txtEmail.text = obj?.email ?? ""
        let countryCode = obj?.countryCode ?? ""
        let Code = countryCode.replacingOccurrences(of: " ", with: "+")
        self.txtPhone.text = "\(Code) \(obj?.mobileNo ?? "")"
        self.lblRating.text = (obj?.rating == "") ? "0.0" : obj?.rating
        
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(obj?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        self.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.imgProfile.sd_setImage(with: strURl, placeholderImage: UIImage(named: "imgDummyProfile"), options: .refreshCached, completed: nil)
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func UploadImage(){
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .alert)
        let Gallery = UIAlertAction(title: "Select photo from gallery"
                                    , style: .default, handler: { ACTION in
                                        self.imagePicker.allowsEditing = false
                                        self.imagePicker.sourceType = .photoLibrary
                                        self.present(self.imagePicker, animated: true)
                                        
                                    })
        let Camera  = UIAlertAction(title: "Select photo from camera", style: .default, handler: { ACTION in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.cameraCaptureMode = .photo
            self.present(self.imagePicker, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { ACTION in
            
        })
        alert.addAction(Gallery)
        alert.addAction(Camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtName.validatedText(validationType: .username(field: self.txtName.placeholder?.lowercased() ?? ""))
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .info)
            return false
        }
        
        return true
    }
    
    // MARK: - --------- Action methods ---------
    @IBAction func btnChangePasswordTap(_ sender: Any) {
        let vc : ChangePasswordVC = ChangePasswordVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMyEarningTap(_ sender: Any) {
        let vc : MyEarningsVC = MyEarningsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEditprofileAction(_ sender: Any) {
        self.checkCamera()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if(self.validation()){
            self.callUpdateUserInfo()
        }
    }
    
    
}

//MARK:- UIImagePickerControllerDelegate Method
extension MyProfileVC : UIImagePickerControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if pickedImage == nil{
            Utilities.showAlert(AppName, message: "Please select image to upload", vc: self)
        }else{
            self.imgProfile.image = pickedImage
            //self.callUploadSingleDocApi(uploadImage: pickedImage!)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // check camera permissin
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: self.UploadImage()
        case .denied: alertToEncourageCameraAccessInitially()
        case .notDetermined: checkCameraAccess()
        default: alertToEncourageCameraAccessInitially()
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            alertToEncourageCameraAccessInitially()
        case .restricted:
            alertToEncourageCameraAccessInitially()
            print("Restricted, device owner must approve")
        case .authorized:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    DispatchQueue.main.async {
                        self.UploadImage()
                        print("Permission granted, proceed")
                    }
                    
                } else {
                    print("Permission denied")
                }
            }
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    DispatchQueue.main.async {
                        self.UploadImage()
                        print("Permission granted, proceed")
                    }
                    
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("Dafaukt casr < Image Picker class")
        }
    }
    
    func alertToEncourageCameraAccessInitially() {
        Utilities.showAlertWithTitleFromVC(vc: self, title: "", message: "Camera access required for capturing photos!", buttons: ["Cancel","Allow Camera"], isOkRed: false) { (ind) in
            if ind == 1{
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        }
    }
}

//MARK:- Api Call
extension MyProfileVC{
    
    func callUpdateUserInfo(){
        self.userInfoViewModel.myProfileVC = self
        
        let UploadReq = UpdateUserInfoReqModel()
        UploadReq.fullName = self.txtName.text ?? ""
        UploadReq.email = self.txtEmail.text ?? ""
        let splits = self.txtPhone.text?.components(separatedBy: " ")
        UploadReq.mobileNo = splits?[1] ?? ""
        
        self.userInfoViewModel.webserviceUserInfoUpdateAPI(reqModel: UploadReq, reqImage: self.imgProfile.image!)
    }
    
}

//MARK:- TextField Delegate
extension MyProfileVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtName :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= TEXTFIELD_MaximumLimit) : false
            
        default:
            print("")
        }
       
        return true
    }
}
