//
//  AppDelegate+Methods.swift
//  PickARide User
//
//  Created by apple on 6/29/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import UserNotifications
import GoogleMaps

extension AppDelegate{
    
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let logInVC = storyboard.instantiateViewController(identifier: "LogInVC") as! LogInVC
            window?.rootViewController = UINavigationController(rootViewController: logInVC)
        }else{
            let logInVC = storyboard.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
            window?.rootViewController = UINavigationController(rootViewController: logInVC)
        }
    }
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let MainVC = storyboard.instantiateViewController(identifier: MainViewController.className) as! MainViewController
            MainVC.navigationController?.navigationBar.isHidden = false
            window?.rootViewController = UINavigationController(rootViewController: MainVC)
        }else{
            let MainVC = storyboard.instantiateViewController(withIdentifier: MainViewController.className) as! MainViewController
            MainVC.navigationController?.navigationBar.isHidden = false
            window?.rootViewController = UINavigationController(rootViewController: MainVC)
        }
    }
    
    func dologout(){
        for (key, _) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        
        userDefaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        Singleton.sharedInstance.clearSingletonClass()
        userDefaults.setUserData()
        userDefaults.synchronize()
        AppDel.navigateToLogin()
    }
}
