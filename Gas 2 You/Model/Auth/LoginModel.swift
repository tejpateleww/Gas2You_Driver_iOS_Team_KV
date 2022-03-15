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
   
    
#if IOS_SIMULATOR
    var latitude : String? = "0.0"
    var longitude : String? = "0.0"
#else
    var latitude : String? = Singleton.sharedInstance.locationString().latitude
    var longitude : String? = Singleton.sharedInstance.locationString().longitude
#endif
    
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
    var id, fullName: String?
    var notification : String?
    var email, countryCode, mobileNo: String?
    var accountHolderName, bankName, ifscCode, accountNumber: String?
    var walletBalance, profileImage, deviceType: String?
    var deviceToken, lat, lng, qrCode: String?
    var isVerify, busy, duty, referralCode, inviteCode: String?
    var rememberToken, verifyToken, status: String?
    var createdAt, updatedAt, deletedAt, rating, xAPIKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email = "email"
        case countryCode = "country_code"
        case mobileNo = "mobile_no"
        case accountHolderName = "account_holder_name"
        case bankName = "bank_name"
        case ifscCode = "ifsc_code"
        case accountNumber = "account_number"
        case walletBalance = "wallet_balance"
        case profileImage = "profile_image"
        case deviceType = "device_type"
        case deviceToken = "device_token"
        case lat = "lat"
        case lng = "lng"
        case qrCode = "qr_code"
        case isVerify = "is_verify"
        case busy = "busy"
        case duty = "duty"
        case referralCode = "referral_code"
        case inviteCode = "invite_code"
        case rememberToken = "remember_token"
        case verifyToken = "verify_token"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case rating = "rating"
        case xAPIKey = "x-api-key"
        case notification = "notification"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        id = try? values?.decodeIfPresent(String.self, forKey: .id)
        fullName = try? values?.decodeIfPresent(String.self, forKey: .fullName)
        email = try? values?.decodeIfPresent(String.self, forKey: .email)
        countryCode = try? values?.decodeIfPresent(String.self, forKey: .countryCode)
        mobileNo = try? values?.decodeIfPresent(String.self, forKey: .mobileNo)
        accountHolderName = try? values?.decodeIfPresent(String.self, forKey: .accountHolderName)
        bankName = try? values?.decodeIfPresent(String.self, forKey: .bankName)
        ifscCode = try? values?.decodeIfPresent(String.self, forKey: .ifscCode)
        accountNumber = try? values?.decodeIfPresent(String.self, forKey: .accountNumber)
        walletBalance = try? values?.decodeIfPresent(String.self, forKey: .walletBalance)
        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
        deviceType = try? values?.decodeIfPresent(String.self, forKey: .deviceType)
        deviceToken = try? values?.decodeIfPresent(String.self, forKey: .deviceToken)
        lat = try? values?.decodeIfPresent(String.self, forKey: .lat)
        lng = try? values?.decodeIfPresent(String.self, forKey: .lng)
        qrCode = try? values?.decodeIfPresent(String.self, forKey: .qrCode)
        isVerify = try? values?.decodeIfPresent(String.self, forKey: .isVerify)
        busy = try? values?.decodeIfPresent(String.self, forKey: .busy)
        duty = try? values?.decodeIfPresent(String.self, forKey: .duty)
        referralCode = try? values?.decodeIfPresent(String.self, forKey: .referralCode)
        inviteCode = try? values?.decodeIfPresent(String.self, forKey: .inviteCode)
        rememberToken = try? values?.decodeIfPresent(String.self, forKey: .rememberToken)
        verifyToken = try? values?.decodeIfPresent(String.self, forKey: .verifyToken)
        status = try? values?.decodeIfPresent(String.self, forKey: .status)
        createdAt = try? values?.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try? values?.decodeIfPresent(String.self, forKey: .updatedAt)
        deletedAt = try? values?.decodeIfPresent(String.self, forKey: .deletedAt)
        rating = try? values?.decodeIfPresent(String.self, forKey: .rating)
        xAPIKey = try? values?.decodeIfPresent(String.self, forKey: .xAPIKey)
        notification = try? values?.decodeIfPresent(String.self, forKey: .notification)
        
    }
    
}

//MARK:- Apple User Model
class AppleUserDetailModel: Codable{
    
}
