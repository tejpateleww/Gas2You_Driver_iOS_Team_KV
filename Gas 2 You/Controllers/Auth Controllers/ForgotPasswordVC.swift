//
//  ForgotPasswordVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class ForgotPasswordVC: BaseVC {
    
    //MARK:- Variables
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var btnSubmit: ThemeButton!
    
    var forgotPasswordUserModel = PasswordUserModel()
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Forgot Password", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK:- Button action methods
    @IBAction func btnSubmitTap(_ sender: ThemeButton) {
        if self.validation(){
            self.callForgotPasswordApi()
        }
    }
    
    //MARK:- Extra methods
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Validation & Api
extension ForgotPasswordVC{
    func validation()->Bool{
        var strTitle : String?
        let checkEmail = self.txtEmail.validatedText(validationType: .email)
        
        if !checkEmail.0{
            strTitle = checkEmail.1
        }

        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callForgotPasswordApi(){
        self.forgotPasswordUserModel.forgotPasswordVC = self
        
        let reqModel = ForgotPasswordReqModel()
        reqModel.email = self.txtEmail.text ?? ""
        
        self.forgotPasswordUserModel.webserviceForgotPassword(reqModel: reqModel)
    }
}
