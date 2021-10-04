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
}
