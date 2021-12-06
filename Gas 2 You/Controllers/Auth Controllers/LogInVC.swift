//
//  LogInVC.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit
import SafariServices

class LogInVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfieldWithNoPaste!
    @IBOutlet weak var btnSignUp: themeButton!
    @IBOutlet weak var lblByLoginText: themeLabel!
    @IBOutlet weak var lblAnd: themeLabel!
    @IBOutlet weak var lblDontHAveAcc: themeLabel!
    
    var loginUserModel = LoginUserModel()
    var locationManager : LocationService?
    
    let ACCEPTABLE_CHARACTERS_FOR_EMAIL = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@."
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "

    
    //MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfields(textfield: txtPassword)
        self.btnSignUp.setunderline(title: self.btnSignUp.titleLabel?.text ?? "", color: .white, font: ATFontManager.setFont(16, andFontName: FontName.regular.rawValue))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
 
    //MARK: - Common methods
    func setupTextfields(textfield : UITextField) {
        
        textfield.rightViewMode = .always
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 100, height: 40))
        button.setTitle("Forgot?", for: .normal)
        button.setColorFont(color: .gray , font: ATFontManager.setFont(14, andFontName: FontName.semibold.rawValue))
        button.addTarget(self, action: #selector(navigateToForgotPassword), for: .touchUpInside)
        let view = UIView(frame : CGRect(x: 0, y: 0, width: 105, height: 40))
        view.addSubview(button)
        textfield.rightView = view
        
    }
    
    func getLocation() -> Bool {
        if Singleton.sharedInstance.userCurrentLocation == nil{
            self.locationManager = LocationService()
            self.locationManager?.startUpdatingLocation()
            return false
        }else{
            return true
        }
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @objc func navigateToForgotPassword(){
        let loginStory = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let forgotpassVC = loginStory.instantiateViewController(identifier: ForgotPasswordVC.className) as! ForgotPasswordVC
            navigationController?.pushViewController(forgotpassVC, animated: true)
        }else{
            let forgotpassVC = loginStory.instantiateViewController(withIdentifier: ForgotPasswordVC.className) as! ForgotPasswordVC
            navigationController?.pushViewController(forgotpassVC, animated: true)
        }
    }
    
    //MARK: - Button actions
    @IBAction func logInButtonPreesed(_ sender: ThemeButton) {
        if self.validation(){
            if self.getLocation(){
                self.callLoginApi()
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: themeButton) {
        
        if #available(iOS 13.0, *) {
            let signUpVC = storyboard?.instantiateViewController(identifier: SignUpVC.className) as! SignUpVC
            navigationController?.pushViewController(signUpVC, animated: true)
        }else{
            let signUpVC = storyboard?.instantiateViewController(withIdentifier: SignUpVC.className) as! SignUpVC
            navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
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
}

//MARK: - Validation & Api
extension LogInVC{
    func validation()->Bool{
        var strTitle : String?
        
        if(self.txtEmail.text == ""){
            Toast.show(title: UrlConstant.Required, message: "Please enter email", state: .info)
            return false
        }
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let password = self.txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !password.0{
            strTitle = password.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .info)
            return false
        }
        
        return true
    }
    
    func callLoginApi(){
        self.loginUserModel.loginVC = self
        
        let reqModel = LoginRequestModel()
        reqModel.userName = self.txtEmail.text ?? ""
        reqModel.password = self.txtPassword.text ?? ""
        
        self.loginUserModel.webserviceLogin(reqModel: reqModel)
    }
}

//MARK: - TextField Delegate
extension LogInVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtEmail :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_EMAIL).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)

        case self.txtPassword :
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
