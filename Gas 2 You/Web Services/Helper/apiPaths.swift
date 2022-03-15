//
//  apiPaths.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 04/06/21.
//

import Foundation

typealias NetworkRouterCompletion = ((Data?,[String:Any]?, Bool) -> ())

enum APIEnvironment : String {
 
//Development URL : Pick A Ride Customer
    case AssetsUrl = ""
    case Profilebu = "https://gas2youcenla.com/"
    case Development = "http://dev.gas2youcenla.com/api/driver_api/"
    case Live = "https://gas2youcenla.com/api/driver_api/"
     
    static var baseURL: String{
        return APIEnvironment.environment.rawValue
    }
    
    static var environment: APIEnvironment{
        return .Development
    }
    
    static var headers : [String:String]{
        if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) != nil {
            
            if userDefaults.object(forKey: UserDefaultsKey.isUserLogin.rawValue) as? Bool == true {
                
                if userDefaults.object(forKey:  UserDefaultsKey.userProfile.rawValue) != nil {
                    do {
                        if UserDefaults.standard.value(forKey: UserDefaultsKey.X_API_KEY.rawValue) != nil, UserDefaults.standard.value(forKey:  UserDefaultsKey.isUserLogin.rawValue) as? Bool ?? Bool(){
                            return [UrlConstant.HeaderKey : UrlConstant.AppHostKey, UrlConstant.XApiKey : Singleton.sharedInstance.UserProfilData?.xAPIKey ?? ""]
                        }else{
                            return [UrlConstant.HeaderKey : UrlConstant.AppHostKey]
                        }
                    }
                }
            }
        }
        return [UrlConstant.HeaderKey : UrlConstant.AppHostKey]
    }
}

enum ApiKey: String {
    case Init                                 = "init/ios_driver/"
    case login                                = "login"
    case register                             = "register"
    case changePassword                       = "change_password"
    case forgotPassword                       = "forgot_password"
    case registerOtp                          = "register_otp"
    
    case homeReqBooking                       = "request_order_list"
    case homeInProgressBooking                = "in_process_order_list"
    case updateOrderStatus                    = "update_order_status"
    case completeOrder                        = "complete_order"
    case getCompleteOrderList                 = "get_complete_order_list"
    case updateProfile                        = "update_profile"
    case messageList                          = "message_list/"
    case downloadInvoice                      = "download_invoice"
    case sendMessage                          = "send_message"
    case chatHistory                          = "chat_history/"
    case notification                         = "notification"
    case earningList                          = "earning_list"
    case changeNotification                   = "change_notification"
    case rating                               = "get_rating/"
    case logout                               = "logout/"
    
}

 

enum SocketKeys: String {
    
    case KHostUrl                                 = "https://gas2youcenla.com/app/"
    case ConnectUser                              = "connect_driver"
    case channelCommunation                       = "communication"
    case SendMessage                              = "send_message"
    case ReceiverMessage                          = "receiver_message"
    
}
