//
//  Singleton.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 09/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Singleton: NSObject{
    static let sharedInstance = Singleton()
    
    var UserId = String()
    var AppInitModel : InitResponseModel?
    var UserProfilData : ProfileModel?
    var Api_Key = String()
    var DeviceType : String = "ios"
    var DeviceToken : String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var userCurrentLocation : CLLocationCoordinate2D?
    
    func locationString() -> (latitude: String, longitude: String){
        return (String(userCurrentLocation?.latitude ?? 23.071775), String(userCurrentLocation?.longitude ?? 72.517008))
    }
    
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    func clearSingletonClass() {
        Singleton.sharedInstance.UserId = ""
        Singleton.sharedInstance.Api_Key = ""
        Singleton.sharedInstance.UserProfilData = nil
    }
}

