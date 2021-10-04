//
//  AppInfo.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import Foundation
import UIKit

struct AppInfo {
    
    static var appVersion: String {
        if let app_version = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String {
            return app_version
        } else{
            return "No Version"
        }
    }
    
    static var appName:String{
        return Bundle.appName()
    }
    
    static var appHeaderKey:String{
        return "key"
    }
    
    static var appDynamicHeaderKey:String{
        return "x-api-key"
    }
    
    
    static var appStaticHeader:String{
        return "CoreSound$951"
    }
    
    static var deviceType:String{
        return "ios"
    }
    
    static var appUrl:String{
        return "itms-apps://itunes.apple.com/app/id1488928328"
    }
    
    static var Google_Client_Id: String {
        return ""
    }
    
    static var Google_API_Key: String {
        return  "AIzaSyDU7rSEixg3F-ceR5nz9JAcYxEw5J7hOEI" // App Key : AIzaSyAiBKDiFXeYbV2f23EBtmpk8pmZYgNgExo"
    }
}


extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
