//
//  LoginViewModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class LoginUserModel{
    weak var loginVC : LogInVC? = nil
    
    func webserviceLogin(reqModel: LoginRequestModel){
        self.loginVC?.btnLogin.showLoading()
        WebServiceSubClass.LoginApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.loginVC?.btnLogin.hideLoading()
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

class LogoutUserModel{
    
    weak var leftViewController : LeftViewController? = nil

    func webserviceUserLogoutAPI(){
        WebServiceSubClass.userLogoutApi{ (status, apiMessage, response, error) in
            if status{
                self.leftViewController?.userLogout()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
}
