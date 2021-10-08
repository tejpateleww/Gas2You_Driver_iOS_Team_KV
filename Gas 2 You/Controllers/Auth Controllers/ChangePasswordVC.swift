//
//  ChangePasswordVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class ChangePasswordVC: BaseVC {
    
    //MARK:- Variables
    @IBOutlet weak var imgG2U: UIImageView!
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var txtCurrentPassword: themeTextfield!
    @IBOutlet weak var txtNewPassword: themeTextfield!
    @IBOutlet weak var txtReEnterPassword: themeTextfield!
    @IBOutlet weak var btnSave: ThemeButton!
    
    var changePasswordUserModel = PasswordUserModel()
    var btnSubmitClosure : (() -> ())?
    let RISTRICTED_CHARACTERS_FOR_PASSWORD = " "
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Change Password", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK:- Button action methods
    @IBAction func btnSaveTap(_ sender: ThemeButton) {
        if self.validation(){
            self.callChangePasswordApi()
        }
    }
    
    //MARK:- Extra methods
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- Validation & Api
extension ChangePasswordVC{
    
    func validation()->Bool{
        var strTitle : String?
        let oldPassword = self.txtCurrentPassword.validatedText(validationType: .password(field: self.txtCurrentPassword.placeholder?.lowercased() ?? ""))
        let newPassword = self.txtNewPassword.validatedText(validationType: .password(field: self.txtNewPassword.placeholder?.lowercased() ?? ""))
        let confirmPassword = self.txtReEnterPassword.validatedText(validationType: .requiredField(field: self.txtReEnterPassword.placeholder?.lowercased() ?? ""))
        
        if !oldPassword.0{
            strTitle = oldPassword.1
        }else if !newPassword.0{
            strTitle = newPassword.1
        }else if !confirmPassword.0{
            strTitle = confirmPassword.1
        }else if self.txtNewPassword.text != self.txtReEnterPassword.text{
            strTitle = "New password & confirm password should be same."
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callChangePasswordApi(){
        self.changePasswordUserModel.changePasswordVC = self
        
        let reqModel = ChangePasswordReqModel()
        reqModel.oldPassword = self.txtCurrentPassword.text ?? ""
        reqModel.newPassword = self.txtNewPassword.text ?? ""
        
        self.changePasswordUserModel.webserviceChangePassword(reqModel: reqModel)
    }
}

//MARK:- TextField Delegate
extension ChangePasswordVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        
        case self.txtCurrentPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        case self.txtNewPassword :
            let set = CharacterSet(charactersIn: RISTRICTED_CHARACTERS_FOR_PASSWORD)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            return (string != filtered) ? (newString.length <= TEXTFIELD_PASSWORD_MaximumLimit) : (isBackSpace == -92) ? true : false
            
        case self.txtReEnterPassword :
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
