//
//  RegisterViewModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

class RegisterUserModel{
    weak var registerVc : SignUpVC? = nil
    
    func webserviceRegister(reqModel: RegisterRequestModel){
        Utilities.showHud()
        WebServiceSubClass.RegisterApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            Toast.show(title: status ? UrlConstant.Success : UrlConstant.Failed, message: apiMessage, state: status ? .success : .failure)
            
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
            }
        }
    }
}
