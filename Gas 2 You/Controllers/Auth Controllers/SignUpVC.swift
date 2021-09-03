//
//  SignUpVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit

class SignUpVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtFirstName: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtMobile: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var txtConfirmPassword: themeTextfield!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnLoginNow: themeButton!
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Sign Up", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
        self.btnLoginNow.setunderline(title: "Login Now" , color: .white, font: CustomFont.PoppinsSemiBold.returnFont(16))
        
        //mobile no field +1 related code
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
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
    
    //MARK:- IBAction
    @IBAction func btnPrivacyPolicyTap(_ sender: Any) {
        
    }
    
    @IBAction func btnLoginNowTap(_ sender: Any) {
        
    }
    
    @IBAction func btnSignupTap(_ sender: Any) {
        if self.validation(){
            if(self.txtPassword.text != self.txtConfirmPassword.text){
                Toast.show(title: UrlConstant.Required, message: UrlConstant.PasswordNotMatch, state: .failure)
            }else{
                if self.validation(){
                    
                    let reqModel = RegisterRequestModel()
                    reqModel.fullName = self.txtFirstName.text ?? ""
                    reqModel.email = self.txtEmail.text ?? ""
                    reqModel.countryCode = DefaultCouuntryCode
                    reqModel.phone = self.txtMobile.text ?? ""
                    reqModel.password = self.txtPassword.text ?? ""
                    
                    let OtpVC = storyboard?.instantiateViewController(identifier: OtpVC.className) as! OtpVC
                    OtpVC.registerReqModel = reqModel
                    navigationController?.pushViewController(OtpVC, animated: true)
                    
                }
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
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        let mobileNo = self.txtMobile.validatedText(validationType: .requiredField(field: self.txtMobile.placeholder?.lowercased() ?? ""))
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
        if textField == txtMobile || textField == txtFirstName || textField == txtConfirmPassword || textField == txtPassword{
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return string == "" || (newString.length <= ((textField == txtMobile) ? MAX_PHONE_DIGITS : TEXTFIELD_MaximumLimit))
        }
        return true
    }
}
