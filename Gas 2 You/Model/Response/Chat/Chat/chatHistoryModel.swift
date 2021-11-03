//
//  chatHistoryModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2021

import Foundation

class chatHistoryModel : Codable {
    
    let data : [chatHistoryDatum]?
    let message : String?
    let status : Bool?
    let customerName : String?
    let customerId : String?
    let bookingId : String?
    let customerProfilePicture : String?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
        case customerId = "customer_id"
        case bookingId = "booking_id"
        case customerName = "customer_name"
        case customerProfilePicture = "customer_profile_picture"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([chatHistoryDatum].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
        customerProfilePicture = try values.decodeIfPresent(String.self, forKey: .customerProfilePicture)
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        customerId = try values.decodeIfPresent(String.self, forKey: .customerId)
    }
    
}
