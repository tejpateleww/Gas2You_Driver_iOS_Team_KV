//
//  AppDelegate.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps

let AppDel = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //Location
    var locationService = LocationService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyAsK4EKl6GkGqELS8YySwoIWVjNjAwR7dg")
        window?.makeKeyAndVisible()
    
        return true
    }
    

}


