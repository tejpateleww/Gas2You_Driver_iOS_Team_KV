//
//  NotiStatusChangeViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 29/11/21.
//

import Foundation

class NotiChangeViewModel{
    
    weak var settingsVC : SettingsVC? = nil
    
    func webserviceNotiStatusChangeAPI(reqModel: NotificationStatusReqModel){
        WebServiceSubClass.changeNotificationStatusApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                if status{
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
                    
                    if(Singleton.sharedInstance.UserProfilData?.notification == "1"){
                        self.settingsVC?.switchNotification.setOn(true, animated: true)
                    }else{
                        self.settingsVC?.switchNotification.setOn(false, animated: true)
                    }
                }else{
                    Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
                }
            }
        }
    }
    
}
