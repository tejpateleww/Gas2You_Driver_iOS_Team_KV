//
//  PasswordViewModel.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class PasswordUserModel{
    
    weak var forgotPasswordVC : ForgotPasswordVC? = nil
    weak var changePasswordVC : ChangePasswordVC? = nil
    
    func webserviceForgotPassword(reqModel: ForgotPasswordReqModel){
        Utilities.showHud()
        WebServiceSubClass.ForgotPasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.forgotPasswordVC!) {
                    self.forgotPasswordVC?.popBack()
                }
            }else{
                Toast.show(title:UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceChangePassword(reqModel: ChangePasswordReqModel){
        Utilities.showHud()
        
        WebServiceSubClass.ChangePasswordApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            
            if status{
                if let click = self.changePasswordVC?.btnSubmitClosure {
                    click()
                }
                self.clearAllFields()
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.changePasswordVC!) {
                    self.changePasswordVC?.popBack()
                }
            }else{
                Toast.show(title:UrlConstant.Failed, message: apiMessage, state: .failure)
            }
    
        }
    }
    
    func clearAllFields(){
        changePasswordVC?.txtCurrentPassword.text = ""
        changePasswordVC?.txtNewPassword.text = ""
        changePasswordVC?.txtReEnterPassword.text = ""
        
    }
}
