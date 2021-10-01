//
//  JobReqModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 01/10/21.
//

import Foundation

class JobStatusUpdateReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var orderId : String?
    var orderStatus : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case orderId = "order_id"
        case orderStatus = "order_status"
    }
}

class JobCompReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var orderId : String?
    var totalGallon : String?
    var pricePerGallon : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case orderId = "order_id"
        case totalGallon = "total_gallon"
        case pricePerGallon = "price_per_gallon"
    }
}
