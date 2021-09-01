//
//  ProfileModel.swift
//  PickARide User
//
//  Created by apple on 7/8/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit
class ProfileReqModel: Encodable{
    var customerId: String? = Singleton.sharedInstance.UserId
    var firstName: String?
    var lastName: String?
    var mobileNo : String?
    var birthDate: String?
    var gender: String?
    var address: String?
    var profileImage : UIImage?
    var profilePictureKey : String? = "profile_image"
    
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case mobileNo = "mobile_no"
        case birthDate = "dob"
        case gender = "gender"
        case address = "address"
    }
}
