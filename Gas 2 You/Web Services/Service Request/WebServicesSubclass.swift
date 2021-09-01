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

}
