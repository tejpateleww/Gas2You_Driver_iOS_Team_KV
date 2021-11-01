//
//  ChatUserListDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2021

import Foundation

class ChatUserListDatum : Codable {
    
    let bookingId : String?
    let createdAt : String?
    let fullName : String?
    let image : String?
    let message : String?
    let receiverId : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case createdAt = "created_at"
        case fullName = "full_name"
        case image = "image"
        case message = "message"
        case receiverId = "receiver_id"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
    }
    
}
