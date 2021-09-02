//
//  PasswordModel.swift
//  PickARide User
//
//  Created by apple on 7/6/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation

//MARK:- Forgot Password Request Model
class ForgotPasswordReqModel: Encodable{
    var email : String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

//MARK:- Change Password Request Model
class ChangePasswordReqModel: Encodable{
    var oldPassword : String?
    var newPassword : String?
    var driverId : String? = Singleton.sharedInstance.UserId
    
    enum CodingKeys: String, CodingKey {
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case driverId = "driver_id"
    }
}

//MARK:- Password Response Model
class PasswordResponseModel: Codable {
    let status: Bool?
    let message: String?

    init(status: Bool, message: String) {
        self.status = status
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? values?.decodeIfPresent(Bool.self, forKey: .status)
        message = try? values?.decodeIfPresent(String.self, forKey: .message)
    }
}
