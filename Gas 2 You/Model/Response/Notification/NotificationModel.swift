//
//  NotificationModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 17, 2021

import Foundation

class NotificationModel : Codable {
    
    let message : String?
    let data : [NotificationDatum]?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([NotificationDatum].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
