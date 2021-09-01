//
//  LoginModel.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Request Model
class LoginRequestModel: Encodable{
    var userName : String?
    var password : String?
    var deviceType : String? = Singleton.sharedInstance.DeviceType
    var deviceToken : String? = Singleton.sharedInstance.DeviceToken
    var latitude : String? = Singleton.sharedInstance.locationString().latitude
    var longitude : String? = Singleton.sharedInstance.locationString().longitude
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password = "password"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case latitude = "lat"
        case longitude = "lng"
    }
}

//MARK:- Response Model
class LoginResponseModel: Codable{
    var status: Bool?
    var message: String?
    var data: ProfileModel?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        data = try? values?.decodeIfPresent(ProfileModel.self, forKey: .data)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
    }
}

// MARK: - DataClass
class ProfileModel: Codable {
    var id, companyID, firstName, lastName: String?
    var email, countryID, countryCode, mobileNo: String?
    var dob, gender, walletBalance, deviceType: String?
    var deviceToken, lat, lng, qrCode: String?
    var profileImage, socialID, socialType, rememberToken: String?
    var address, trash, status, referralCode: String?
    var createdAt, rating, xAPIKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case countryID = "country_id"
        case countryCode = "country_code"
        case mobileNo = "mobile_no"
        case dob, gender
        case walletBalance = "wallet_balance"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case lat, lng
        case qrCode = "qr_code"
        case profileImage = "profile_image"
        case socialID = "social_id"
        case socialType = "social_type"
        case rememberToken = "remember_token"
        case address, trash, status
        case referralCode = "referral_code"
        case createdAt = "created_at"
        case rating
        case xAPIKey = "x-api-key"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        address = try? values?.decodeIfPresent(String.self, forKey: .address)
        companyID = try? values?.decodeIfPresent(String.self, forKey: .companyID)
        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
        countryID = try? values?.decodeIfPresent(String.self, forKey: .countryID)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        deviceToken = try? values?.decodeIfPresent(String.self, forKey: .deviceToken)
        deviceType = try? values?.decodeIfPresent(String.self, forKey: .deviceType)
        dob = try? values?.decodeIfPresent(String.self, forKey: .dob)
        email = try? values?.decodeIfPresent(String.self, forKey: .email)
        firstName = try? values?.decodeIfPresent(String.self, forKey: .firstName)
        gender = try? values?.decodeIfPresent(String.self, forKey: .gender)
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        lastName = try? values?.decodeIfPresent(String.self, forKey: .lastName)
        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
        mobileNo = try? values?.decodeIfPresent(String.self, forKey: .mobileNo)
        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
        qrCode = try? values?.decodeIfPresent(String.self, forKey: .qrCode)
        rating = try? values?.decodeIfPresent(String.self, forKey: .rating)
        referralCode = try? values?.decodeIfPresent(String.self, forKey: .referralCode)
        rememberToken = try? values?.decodeIfPresent(String.self, forKey: .rememberToken)
        socialID = try? values?.decodeIfPresent(String.self, forKey: .socialID)
        socialType = try? values?.decodeIfPresent(String.self, forKey: .socialType)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        trash = try? values?.decodeIfPresent(String.self, forKey: .trash)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
        xAPIKey = try? values?.decodeIfPresent(String.self, forKey: .xAPIKey)
    }
    
}

//MARK:- Apple User Model
class AppleUserDetailModel: Codable{
    
}
