//
//  UserRatingViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 05/01/22.
//

import Foundation

class UserRatingViewModel{
    
    weak var myProfileVC : MyProfileVC? = nil

    func webserviceUserRatingAPI(){
        WebServiceSubClass.userRatingApi{ (status, apiMessage, response, error) in
            if status{
                self.myProfileVC?.updateUserRating(rating: response?.rating ?? "0.0")
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
}
