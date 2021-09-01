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
    
    func checkAndSetDefaultLanguage() {
        if userDefaults.value(forKey: UserDefaultsKey.selLanguage.rawValue) == nil {
            setLanguageEnglish()
        }
    }
    
    func setLanguageEnglish() {
        userDefaults.setValue("en", forKey: UserDefaultsKey.selLanguage.rawValue)
    }
    
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyboard.instantiateViewController(identifier: "LogInVC") as! LogInVC
        window?.rootViewController = UINavigationController(rootViewController: logInVC)
    }
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainVC = storyboard.instantiateViewController(identifier: MainViewController.className) as! MainViewController
        MainVC.navigationController?.navigationBar.isHidden = false
        window?.rootViewController = UINavigationController(rootViewController: MainVC)
    }
    
    func clearData(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if key != UserDefaultsKey.DeviceToken.rawValue && key  != "language"  {
                print("\(key) = \(value) \n")
                 UserDefaults.standard.removeObject(forKey: key)
            }
        }
        
        
        userDefaults.set(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
        Singleton.sharedInstance.clearSingletonClass()
        userDefaults.setUserData()
    }
    
    func dologout(){
        
    }
}
