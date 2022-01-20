//
//  RegisterModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- OTP Request Model
class OTPRequestModel : Encodable{
    var email: String?
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

//MARK:- OTP Response Model
class OTPResponseModel: Codable {
    var status: Bool?
    var otp: String?
    var message: String?

    init(status: Bool?, otp: String?, message: String?) {
        self.status = status
        self.otp = otp
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        otp = try? values?.decodeIfPresent(String.self, forKey: .otp)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
    }
}

//MARK:- Register Request Model
class RegisterRequestModel: Encodable{
    var fullName : String?
    var email : String?
    var password : String?
    var phone : String?
    var countryCode : String? = "+1"
    var deviceType : String? = Singleton.sharedInstance.DeviceType
    var deviceToken : String? = Singleton.sharedInstance.DeviceToken
    var latitude : String? = Singleton.sharedInstance.locationString().latitude
    var longitude : String? = Singleton.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email = "email"
        case password = "password"
        case phone = "mobile_no"
        case latitude = "lat"
        case longitude = "lng"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case countryCode = "country_code"
    }
}
