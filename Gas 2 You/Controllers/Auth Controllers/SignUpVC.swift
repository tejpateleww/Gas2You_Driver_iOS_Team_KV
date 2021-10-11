//
//  SignUpVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit
import SafariServices

class SignUpVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtFirstName: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtMobile: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var txtConfirmPassword: themeTextfield!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnLoginNow: themeButton!
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    let ACCEPTABLE_CHARACTERS_FOR_PHONE = "0123456789"
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "

    var strOtp = ""
    var otpUserModel = OTPUserModel()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Sign Up", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
        self.btnLoginNow.setunderline(title: "Login Now" , color: .white, font: CustomFont.PoppinsSemiBold.returnFont(16))
        
        //mobile no field +1 related code
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        self.txtMobile.leftView = paddingView
        self.txtMobile.leftViewMode = .always
        self.txtMobile.layer.borderWidth = 1
        self.txtMobile.layer.borderColor = UIColor.white.cgColor
        self.txtMobile.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK:- Custom Methods
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "IC_selectedCheckGray"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    func goToOTP(){
        let reqModel = RegisterRequestModel()
        reqModel.fullName = self.txtFirstName.text?.trimmingCharacters(in: .whitespaces)
        reqModel.email = self.txtEmail.text ?? ""
        reqModel.countryCode = DefaultCouuntryCode
        reqModel.phone = self.txtMobile.text ?? ""
        reqModel.password = self.txtPassword.text ?? ""
        
        let OtpVC = storyboard?.instantiateViewController(identifier: OtpVC.className) as! OtpVC
        OtpVC.registerReqModel = reqModel
        OtpVC.strOtp = self.strOtp
        navigationController?.pushViewController(OtpVC, animated: true)
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    //MARK:- IBAction
    @IBAction func btnTCAction(_ sender: Any) {
        var TC = ""
        if let TCLink = Singleton.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "terms_and_condition"}) {
            if TCLink.count > 0 {
                TC = TCLink[0].url ?? ""
                self.previewDocument(strURL: TC)
            }
        }
    }
    
    @IBAction func btnPPAction(_ sender: Any) {
        var PrivacyPolicy = ""
        if let PrivacyPolicyLink = Singleton.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "privacy_policy"}) {
            if PrivacyPolicyLink.count > 0 {
                PrivacyPolicy = PrivacyPolicyLink[0].url ?? ""
                self.previewDocument(strURL: PrivacyPolicy)
            }
        }
    }
    
    @IBAction func btnLoginNowTap(_ sender: Any) {
        
    }
    
    @IBAction func btnSignupTap(_ sender: Any) {
        if self.validation(){
            if(self.txtPassword.text != self.txtConfirmPassword.text){
                Toast.show(title: UrlConstant.Required, message: UrlConstant.PasswordNotMatch, state: .failure)
            }else{
                self.callOtpApi()
            }
        }
    }
    
    @IBAction func logInNowButtonPressed(_ sender: themeButton){
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- Validation & Api
extension SignUpVC{
    func validation()->Bool{
        var strTitle : String?
        let firstName = self.txtFirstName.validatedText(validationType: .username(field: self.txtFirstName.placeholder?.lowercased() ?? ""))
        if(self.txtEmail.text == "" && !firstName.0 == false){
            Toast.show(title: UrlConstant.Required, message: "Please enter email", state: .failure)
            return false
        }
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let mobileNo = self.txtMobile.validatedText(validationType: .phoneNo)
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !firstName.0{
            strTitle = firstName.1
        }else if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !mobileNo.0{
            strTitle = mobileNo.1
        }else if self.txtMobile.text?.count != 10 {
            strTitle = UrlConstant.ValidPhoneNo
        }else if !password.0{
            strTitle = password.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
}

//MARK:- TextField Delegate
extension SignUpVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtFirstName :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= TEXTFIELD_MaximumLimit) : false
            
        case self.txtEmail :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
            
        case self.txtMobile :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_PHONE).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= MAX_PHONE_DIGITS) : false
            
        case self.txtPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        case self.txtConfirmPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        default:
            print("")
        }
       
        return true
    }
}

//MARK:- Api Call
extension SignUpVC{
    
    func callOtpApi(){
        self.otpUserModel.signUpVCp = self
        let otpReqModel = OTPRequestModel()
        otpReqModel.email = self.txtEmail.text ?? ""
        self.otpUserModel.webserviceOtpVerify(reqModel: otpReqModel)
    }
}
