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

class DownloadInvoiceReqModel: Encodable{
    var bookingId : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
    }
}

class SendMsgReqModel: Encodable{
    var bookingId : String?
    var senderId : String? = Singleton.sharedInstance.UserId
    var receiverId : String?
    var message : String?
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case message = "message"
    }
}

class NotificationReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var page : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case page = "page"
    }
}

class EarningReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
    }
}

class NotificationStatusReqModel: Encodable{
    var driverId : String? = Singleton.sharedInstance.UserId
    var notification : String?
    
    enum CodingKeys: String, CodingKey {
        case driverId = "driver_id"
        case notification = "notification"
    }
}
