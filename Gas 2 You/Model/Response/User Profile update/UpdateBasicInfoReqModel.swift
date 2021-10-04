//
//  UpdateBasicInfoReqModel.swift
//  PickaRideDriver
//
//  Created by Tej on 09/09/21.
//

import Foundation

class UpdateUserInfoReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var fullName : String?
    var email : String?
    var mobileNo : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case fullName = "full_name"
        case email = "email"
        case mobileNo = "mobile_no"
    }
}
