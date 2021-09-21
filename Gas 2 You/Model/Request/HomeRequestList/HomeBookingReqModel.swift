//
//  HomeBookingReqModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 20/09/21.
//

import Foundation

class HomeBookingReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var page : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case page = "page"
    }
}
