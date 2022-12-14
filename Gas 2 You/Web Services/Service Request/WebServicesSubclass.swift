//
//  WebServicesSubclass.swift
//  Gas 2 You Driver
//
//  Created by Tej on 31/08/21.
//

import Foundation
import UIKit

class WebServiceSubClass{
    
    //MARK:- Init
    class func InitApi(completion: @escaping (Bool,String,InitResponseModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.Init.rawValue + kAPPVesion, responseModel: InitResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }

    //MARK:- Auth
    class func LoginApi(reqModel: LoginRequestModel, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.login.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func RegisterApi(reqModel : RegisterRequestModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.register.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ChangePasswordApi(reqModel : ChangePasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changePassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func ForgotPasswordApi(reqModel : ForgotPasswordReqModel , completion: @escaping (Bool,String,PasswordResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.forgotPassword.rawValue, requestModel: reqModel, responseModel: PasswordResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func otpRequestApi(reqModel : OTPRequestModel , completion: @escaping (Bool,String,OTPResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.registerOtp.rawValue, requestModel: reqModel, responseModel: OTPResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    //MARK:- Home List
    class func homeBookingRequest(reqModel : HomeBookingReqModel , completion: @escaping (Bool,String,RequestBookingListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.homeReqBooking.rawValue, requestModel: reqModel, responseModel: RequestBookingListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func homeBookingInProgressAPI(reqModel : HomeBookingReqModel , completion: @escaping (Bool,String,RequestBookingListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.homeInProgressBooking.rawValue, requestModel: reqModel, responseModel: RequestBookingListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OrderStatusUpdateAPI(reqModel : JobStatusUpdateReqModel , completion: @escaping (Bool,String,CommonModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.updateOrderStatus.rawValue, requestModel: reqModel, responseModel: CommonModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func OrderCompAPI(reqModel : JobCompReqModel , completion: @escaping (Bool,String,OrderComplateModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.completeOrder.rawValue, requestModel: reqModel, responseModel: OrderComplateModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func complateBookingAPI(reqModel : HomeBookingReqModel , completion: @escaping (Bool,String,RequestBookingListModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.getCompleteOrderList.rawValue, requestModel: reqModel, responseModel: RequestBookingListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func UpdateBasicInfoApi(reqModel : UpdateUserInfoReqModel , imgKey: String, image: UIImage, completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makeImageUploadRequest(urlString: ApiKey.updateProfile.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self, image: image, imageKey: imgKey) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
//    class func getChatUserListApi(completion: @escaping (Bool,String,ChatUserListModel?,Any) -> ()) {
//        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.messageList.rawValue + Singleton.sharedInstance.UserId, responseModel: ChatUserListModel.self) { (status, message, response, error) in
//            completion(status, message, response, error)
//        }
//    }
    
    class func getChatUsersApi(completion: @escaping (Bool,String,ChatUserListModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.messageList.rawValue + Singleton.sharedInstance.UserId, responseModel: ChatUserListModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func getChatHistoryApi(BookingId:String, completion: @escaping (Bool,String,chatHistoryModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.chatHistory.rawValue + BookingId, responseModel: chatHistoryModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func sendMsgAPI(reqModel : SendMsgReqModel , completion: @escaping (Bool,String,ChatSendMsgModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.sendMessage.rawValue, requestModel: reqModel, responseModel: ChatSendMsgModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func downloadInvoiceAPI(reqModel : DownloadInvoiceReqModel , completion: @escaping (Bool,String,DownloadInvoiceModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.downloadInvoice.rawValue, requestModel: reqModel, responseModel: DownloadInvoiceModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func getNotificationListApi(reqModel : NotificationReqModel , completion: @escaping (Bool,String,NotificationModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.notification.rawValue, requestModel: reqModel, responseModel: NotificationModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func getEarningListApi(reqModel : EarningReqModel , completion: @escaping (Bool,String,EarningResModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.earningList.rawValue, requestModel: reqModel, responseModel: EarningResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func changeNotificationStatusApi(reqModel : NotificationStatusReqModel , completion: @escaping (Bool,String,LoginResponseModel?,Any) -> ()){
        URLSessionRequestManager.makePostRequest(urlString: ApiKey.changeNotification.rawValue, requestModel: reqModel, responseModel: LoginResponseModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func userLogoutApi(completion: @escaping (Bool,String,CommonModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.logout.rawValue + Singleton.sharedInstance.UserId, responseModel: CommonModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
    class func userRatingApi(completion: @escaping (Bool,String,UserRatingResModel?,Any) -> ()) {
        URLSessionRequestManager.makeGetRequest(urlString: ApiKey.rating.rawValue + Singleton.sharedInstance.UserId, responseModel: UserRatingResModel.self) { (status, message, response, error) in
            completion(status, message, response, error)
        }
    }
    
}
