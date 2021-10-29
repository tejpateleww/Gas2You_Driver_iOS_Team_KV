//
//  RegisterViewModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class OTPUserModel{
    weak var otpVC : OtpVC? = nil
    weak var signUpVCp : SignUpVC? = nil
    
    func webserviceOtp(reqModel: OTPRequestModel){
        self.otpVC?.btnVerify.showLoading()
        WebServiceSubClass.otpRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.otpVC?.btnVerify.hideLoading()
            if status{
                self.otpVC?.strOtp = response?.otp ?? ""
                self.otpVC?.reversetimer()
                self.otpVC?.clearAllFields()
                self.otpVC?.otpToastDisplay()
            }else{
                Utilities.showAlertAction(AppName, message: apiMessage, vc: self.otpVC!) {
                    self.otpVC?.popBack()
                }
            }
        }
    }
    
    func webserviceOtpVerify(reqModel: OTPRequestModel){
        self.signUpVCp?.btnSignUp.showLoading()
        WebServiceSubClass.otpRequestApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.signUpVCp?.btnSignUp.hideLoading()
            if status{
                self.signUpVCp?.strOtp = response?.otp ?? ""
                self.signUpVCp?.goToOTP()
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceRegister(reqModel: RegisterRequestModel){
        self.otpVC?.btnVerify.showLoading()
        WebServiceSubClass.RegisterApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.otpVC?.btnVerify.hideLoading()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Error, message: apiMessage, state: status ? .success : .failure)
            
            if status{
                userDefaults.setValue(true, forKey: UserDefaultsKey.isUserLogin.rawValue)
                userDefaults.setValue(response?.data?.xAPIKey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                
                Singleton.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                
                if let apikey = response?.data?.xAPIKey{
                    Singleton.sharedInstance.Api_Key = apikey
                    Singleton.sharedInstance.UserProfilData?.xAPIKey = apikey
                    userDefaults.setValue(apikey, forKey: UserDefaultsKey.X_API_KEY.rawValue)
                }
                
                if let userID = response?.data?.id{
                    Singleton.sharedInstance.UserId = userID
                }
                
                appDel.navigateToHome()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
