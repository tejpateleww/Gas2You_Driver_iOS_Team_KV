//
//  AppDelegate.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import Firebase
import FirebaseMessaging
import FirebaseCore
import FirebaseCrashlytics

let AppDel = UIApplication.shared.delegate as! AppDelegate
let user_defaults = UserDefaults.standard

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate{
    
    var window: UIWindow?
    var locationService = LocationService()
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var isChatScreen : Bool = false
    var chatBookingId : String = ""
    static var pushNotificationObj : NotificationObjectModel?
    static var pushNotificationType : String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyAsK4EKl6GkGqELS8YySwoIWVjNjAwR7dg")
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        registerForPushNotifications()
    
        return true
    }
    

}


