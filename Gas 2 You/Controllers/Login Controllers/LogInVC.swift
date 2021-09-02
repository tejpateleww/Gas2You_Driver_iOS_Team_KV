//
//  LogInVC.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit

class LogInVC: UIViewController {
    
    //MARK:- Variables
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var btnSignUp: themeButton!
    
    var loginUserModel = LoginUserModel()
    var locationManager : LocationService?
    
    //MARK:- Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfields(textfield: txtPassword)
        btnSignUp.setunderline(title: btnSignUp.titleLabel?.text ?? "", color: .white, font: CustomFont.PoppinsSemiBold.returnFont(16))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK:- Common methods
    func setupTextfields(textfield : UITextField) {
        
        textfield.rightViewMode = .always
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
        button.setTitle("Forgot?", for: .normal)
        button.setColorFont(color: .gray , font: CustomFont.PoppinsMedium.returnFont(14))
        button.addTarget(self, action: #selector(navigateToForgotPassword), for: .touchUpInside)
        let view = UIView(frame : CGRect(x: 0, y: 0, width: 80, height: 40))
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
    
    @objc func navigateToForgotPassword(){
        let loginStory = UIStoryboard(name: "Main", bundle: nil)
        let forgotpassVC = loginStory.instantiateViewController(identifier: ForgotPasswordVC.className) as! ForgotPasswordVC
        navigationController?.pushViewController(forgotpassVC, animated: true)
    }
    
    //MARK:- Button actions
    @IBAction func logInButtonPreesed(_ sender: ThemeButton) {
        if self.validation(){
            if self.getLocation(){
                self.callLoginApi()
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: themeButton) {
        
        let signUpVC = storyboard?.instantiateViewController(identifier: SignUpVC.className) as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}

//MARK:- Validation & Api
extension LogInVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = txtEmail.validatedText(validationType: .email)
        let password = txtPassword.validatedText(validationType: .password(field: self.txtPassword.placeholder?.lowercased() ?? ""))
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }else if !password.0{
            strTitle = password.1
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
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

//MARK:- TextField Delegate
extension LogInVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPassword {
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || newString.length <= TEXTFIELD_MaximumLimit
        }
        return true
    }
}
