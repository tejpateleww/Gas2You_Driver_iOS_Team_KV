//
//  AppDelegate+PushNotification.swift
//  User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import GoogleMaps
import UserNotifications

extension AppDelegate{
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_ , _ in })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let token = fcmToken ?? "No Token found"
        print("Firebase registration token: \(fcmToken ?? "No Token found")")
        Singleton.sharedInstance.DeviceToken = token
        user_defaults.set(fcmToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
        
        let dataDict:[String: String] = ["token": token]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = token {
                print("Remote instance ID token: \(result)")
                UserDefaults.standard.set(Singleton.sharedInstance.DeviceToken, forKey: UserDefaultsKey.DeviceToken.rawValue)
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("fcmToken : \(fcmToken)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(#function, notification)
        let content = notification.request.content
        let userInfo = notification.request.content.userInfo
        NotificationCenter.default.post(name: NotificationBadges, object: content)

        print(#function, notification)
        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let bookingId = mainDic["gcm.notification.booking_id"]{
                pushObj.booking_id = bookingId as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            // handle chat notification for another user when chat screen is open
            if(appDel.isChatScreen){
                if(AppDelegate.pushNotificationObj?.booking_id != AppDelegate.shared.chatBookingId){
                    completionHandler([.alert, .sound])
                }
            }else if(!appDel.isChatScreen){
                completionHandler([.alert, .sound])
            }
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                appDel.dologout()
                return
            }
            
            if pushObj.type == NotificationTypes.newBooking.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if (UIApplication.appTopViewController()?.isKind(of: MainViewController.self) ?? false){
                        NotificationCenter.default.post(name: .refreshHomeScreen, object: nil)
                    }
                }
                return
            }
            
//            if pushObj.type == NotificationTypes.jobInProgress.rawValue {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    if (UIApplication.appTopViewController()?.isKind(of: MainViewController.self) ?? false){
//                        NotificationCenter.default.post(name: .refreshJobInProgressScreen, object: nil)
//                    }
//                }
//                return
//            }
            
            if pushObj.type == NotificationTypes.newMessage.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if (appDel.isChatScreen){
                        NotificationCenter.default.post(name: .refreshChatScreen, object: nil)
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.jobComplete.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if (UIApplication.appTopViewController()?.isKind(of: CompletedJobsVC.self) ?? false){
                        NotificationCenter.default.post(name: .refreshCompJobsScreen, object: nil)
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.newEarning.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if (UIApplication.appTopViewController()?.isKind(of: MyEarningsVC.self) ?? false){
                        NotificationCenter.default.post(name: .refreshEarningScreen, object: nil)
                    }
                }
                return
            }

        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("USER INFo : ",userInfo)
        
        
        if let mainDic = userInfo as? [String: Any]{
            
            let pushObj = NotificationObjectModel()
            if let bookingId = mainDic["gcm.notification.booking_id"]{
                pushObj.booking_id = bookingId as? String ?? ""
            }
            if let type = mainDic["gcm.notification.type"]{
                pushObj.type = type as? String ?? ""
            }
            if let title = mainDic["title"]{
                pushObj.title = title as? String ?? ""
            }
            if let text = mainDic["text"]{
                pushObj.text = text as? String ?? ""
            }
            
            AppDelegate.pushNotificationObj = pushObj
            AppDelegate.pushNotificationType = pushObj.type
            
            if pushObj.type == NotificationTypes.notifLoggedOut.rawValue {
                appDel.dologout()
                completionHandler()
                return
            }
            
            if pushObj.type == NotificationTypes.newBooking.rawValue{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UIApplication.appTopViewController()?.isKind(of: MainViewController.self) ?? false){
                        NotificationCenter.default.post(name: .refreshHomeScreen, object: nil)
                    }else{
                        NotificationCenter.default.post(name: .refreshHomeScreen, object: nil)
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.jobInProgress.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UIApplication.appTopViewController()?.isKind(of: MainViewController.self) ?? false){
                        NotificationCenter.default.post(name: .refreshJobInProgressScreen, object: nil)
                    }else{
                        NotificationCenter.default.post(name: .refreshJobInProgressScreen, object: nil)
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.newMessage.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (appDel.isChatScreen){
                        if(AppDelegate.pushNotificationObj?.booking_id != AppDelegate.shared.chatBookingId){
                            let dictData:[String: String] = ["Booking_Id": AppDelegate.pushNotificationObj?.booking_id ?? ""]
                            NotificationCenter.default.post(name: .refreshChatScreenWithId, object: nil, userInfo: dictData)
                        }else{
                            AppDelegate.pushNotificationType = nil
                            AppDelegate.pushNotificationObj = nil
                            NotificationCenter.default.post(name: .refreshChatScreen, object: nil)
                        }
                    }else{
                        if(UIApplication.appTopViewController()?.isKind(of: LeftViewController.self) ?? false){
                            NotificationCenter.default.post(name: .goToChatScreen, object: nil)
                            NotificationCenter.default.post(name: .hideSideMenu, object: nil)
                        }else{
                            NotificationCenter.default.post(name: .goToChatScreen, object: nil)
                        }
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.jobComplete.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UIApplication.appTopViewController()?.isKind(of: CompletedJobsVC.self) ?? false){
                        AppDelegate.pushNotificationType = nil
                        AppDelegate.pushNotificationObj = nil
                    }else{
                        NotificationCenter.default.post(name: .goToCompletedScreen, object: nil)
                    }
                }
                return
            }
            
            if pushObj.type == NotificationTypes.newEarning.rawValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (UIApplication.appTopViewController()?.isKind(of: MyEarningsVC.self) ?? false){
                        AppDelegate.pushNotificationType = nil
                        AppDelegate.pushNotificationObj = nil
                    }else{
                        NotificationCenter.default.post(name: .goToEarningScreen, object: nil)
                    }
                }
                return
            }

        }
    }
}

extension Notification.Name {
    static let sessionExpire = NSNotification.Name("sessionExpire")
    static let refreshHomeScreen = NSNotification.Name("refreshHomeScreen")
    static let refreshJobInProgressScreen = NSNotification.Name("refreshJobInProgressScreen")
    static let refreshCompJobsScreen = NSNotification.Name("refreshCompJobsScreen")
    static let refreshEarningScreen = NSNotification.Name("refreshEarningScreen")
    static let refreshChatScreen = NSNotification.Name("refreshChatScreen")
    static let refreshChatScreenWithId = NSNotification.Name("refreshChatScreenWithId")
    static let goToChatScreen = NSNotification.Name("goToChatScreen")
    static let goToCompletedScreen = NSNotification.Name("goToCompletedScreen")
    static let goToEarningScreen = NSNotification.Name("goToEarningScreen")
    static let hideSideMenu = NSNotification.Name("hideSideMenu")
}

enum NotificationTypes : String {
    case notifLoggedOut = "sessionTimeout"
    case newBooking = "newBooking"
    case jobInProgress = "jobInProgress"
    case jobComplete = "jobComplete"
    case newMessage = "newMessage"
    case newEarning = "newEarning"
}

class NotificationObjectModel: Codable {
    var booking_id: String?
    var type: String?
    var title: String?
    var text: String?
}

extension UIApplication {
    class func appTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return appTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return appTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return appTopViewController(controller: presented)
        }
        return controller
    }
}
