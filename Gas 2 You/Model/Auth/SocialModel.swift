//
//  SocialLoginModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
 
//MARK:- Social Login Request Model
class SocialLoginRequestModel: Encodable{
    var socialId : String?
    var socialType : String?
    var firstName : String?
    var lastName : String?
    var userName : String?
    var email : String?
    var mobileNo : String?
    var deviceType : String? = Singleton.sharedInstance.DeviceType
    var deviceToken : String? = Singleton.sharedInstance.DeviceToken
    var latitude : String? = Singleton.sharedInstance.locationString().latitude
    var longitude : String? = Singleton.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case socialId = "social_id"
        case socialType = "social_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case latitude = "lat"
        case longitude = "lng"
        case userName = "username"
        case email = "email"
        case mobileNo = "mobile_no"
    }
}
