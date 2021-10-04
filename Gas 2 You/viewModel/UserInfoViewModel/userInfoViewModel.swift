//
//  userInfoViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 04/10/21.
//

import Foundation
import UIKit

class UserInfoViewModel{
    
    weak var myProfileVC : MyProfileVC? = nil

    func webserviceUserInfoUpdateAPI(reqModel: UpdateUserInfoReqModel, reqImage : UIImage){
        self.myProfileVC?.btnSave.showLoading()
        WebServiceSubClass.UpdateBasicInfoApi(reqModel: reqModel, imgKey: "profile_image", image: reqImage) { (status, apiMessage, response, error) in
            self.myProfileVC?.btnSave.hideLoading()
            if status{
                Singleton.sharedInstance.UserProfilData = response?.data
                userDefaults.setUserData()
                let _ = userDefaults.getUserData()
                self.myProfileVC?.popBack()
                Toast.show(title: UrlConstant.Success, message: apiMessage, state: .success)
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
