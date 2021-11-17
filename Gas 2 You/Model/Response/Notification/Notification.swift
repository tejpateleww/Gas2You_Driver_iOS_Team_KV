//
//  Notification.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 17, 2021

import Foundation

class NotificationDatum : Codable {
    
    let createdAt : String?
    let id : String?
    let notificationMessage : String?
    let notificationTitle : String?
    let readStatus : String?
    let timeago : String?
    let updatedAt : String?
    let userId : String?
    let userType : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case notificationMessage = "notification_message"
        case notificationTitle = "notification_title"
        case readStatus = "read_status"
        case timeago = "timeago"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case userType = "user_type"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        notificationMessage = try values.decodeIfPresent(String.self, forKey: .notificationMessage)
        notificationTitle = try values.decodeIfPresent(String.self, forKey: .notificationTitle)
        readStatus = try values.decodeIfPresent(String.self, forKey: .readStatus)
        timeago = try values.decodeIfPresent(String.self, forKey: .timeago)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userType = try values.decodeIfPresent(String.self, forKey: .userType)
    }
    
}
