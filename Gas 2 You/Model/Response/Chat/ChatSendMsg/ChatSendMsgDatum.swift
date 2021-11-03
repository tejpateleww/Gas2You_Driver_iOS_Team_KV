//
//  ChatSendMsgDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 2, 2021

import Foundation

class ChatSendMsgDatum : Codable {
    
    let bookingId : String?
    let createdAt : String?
    let id : String?
    let message : String?
    let readStatus : String?
    let receiverId : String?
    let receiverType : String?
    let senderId : String?
    let senderType : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case createdAt = "created_at"
        case id = "id"
        case message = "message"
        case readStatus = "read_status"
        case receiverId = "receiver_id"
        case receiverType = "receiver_type"
        case senderId = "sender_id"
        case senderType = "sender_type"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bookingId = try values.decodeIfPresent(String.self, forKey: .bookingId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        readStatus = try values.decodeIfPresent(String.self, forKey: .readStatus)
        receiverId = try values.decodeIfPresent(String.self, forKey: .receiverId)
        receiverType = try values.decodeIfPresent(String.self, forKey: .receiverType)
        senderId = try values.decodeIfPresent(String.self, forKey: .senderId)
        senderType = try values.decodeIfPresent(String.self, forKey: .senderType)
    }
    
}
