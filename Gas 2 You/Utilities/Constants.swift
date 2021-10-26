//
//  Constants.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 02/10/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import UIKit


let keywindow = UIApplication.shared.keyWindow

let appDel = UIApplication.shared.delegate as! AppDelegate
let kAPPVesion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
let AppName = "Gas2You Driver"
let AppURL = "itms-apps://itunes.apple.com/app/id1488928328"

//MARK:- Symbols
let plus = "+"
let minus = "-"
let DefaultCouuntryCode = "+1"
let screenWidth = UIScreen.main.bounds.width
let themeColor = hexStringToUIColor(hex: "2ab6b6")
let themeColorOrange = hexStringToUIColor(hex: "ff8b7b")
let themeColorOffWhite = hexStringToUIColor(hex: "efecef")
let userDefaults = UserDefaults.standard
let themeStatusRed = hexStringToUIColor(hex: "DF1A49")
let themeStatusYellow = hexStringToUIColor(hex: "EFB818")
let themeStatusGreen = hexStringToUIColor(hex: "1AC62F")

//MARK:- Images
let RadioCheckImg = #imageLiteral(resourceName: "ImgRightArrow")
let RadioUncheckImg = #imageLiteral(resourceName: "icCircle")
let HidePassword = #imageLiteral(resourceName: "HidePassword")
let ShowPassword = #imageLiteral(resourceName: "ShowPassword")
let UserPlaceHolder = #imageLiteral(resourceName: "user_placeholder")
let BackImage = #imageLiteral(resourceName: "nav_back")
let GallaryPlaceHolder = #imageLiteral(resourceName: "CameraPlaceHolder")

let NotificationRefreshSideMenu = NSNotification.Name(rawValue:"NotificationRefreshSideMenu")
let NotificationBadges = NSNotification.Name(rawValue: "NotificationBadges")

enum DateFormatterString : String{
    case timeWithDate = "yyyy-MM-dd HH:mm:ss"
    case onlyDate = "yyyy-MM-dd"
}

struct DeviceType {
    
    
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_SE         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_7          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_7PLUS      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

let TEXTFIELD_MaximumLimit = 70 //25
let TEXTFIELD_PASSWORD_MaximumLimit = 15 //25
let TEXTFIELD_MinimumLimit = 2
let MAX_PHONE_DIGITS = 10
let MAX_QUANTITY_DIGITS = 8
