//
//  ATFontManager.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 03/12/21.
//

import Foundation
import UIKit

class ATFontManager: UIFont{
    
    class func setFont( _ iPhone7PlusFontSize: CGFloat? = nil,andFontName fontN : String = FontName.regular.rawValue) -> UIFont{
        
        let defaultFontSize : CGFloat = 16
        
        switch ATDeviceDetector().screenType {
            
        case .iPhone4:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize - 5)!
            }
            return UIFont(name: fontN, size: defaultFontSize - 5)!
            
        case .iPhone5:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize - 3)!
            }
            return UIFont(name: fontN, size: defaultFontSize - 3)!
            
        case .iPhone6AndIphone7:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize)!
            }
            return UIFont(name: fontN, size: defaultFontSize)!
            
        case .iPhone6PAndIPhone7P:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!
        case .iPhoneX:
            
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? defaultFontSize)!
          
        case .iPadMini:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 2)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 2)!
            
        case .iPadPro10Inch:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 4)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 4)!
            
        case .iPadPro:
            if let fontSize = iPhone7PlusFontSize{
                return UIFont(name: fontN, size: fontSize + 6)!
            }
            return UIFont(name: fontN, size: defaultFontSize + 6)!

        default:
            return UIFont(name: fontN, size: iPhone7PlusFontSize ?? 16)!
        }
    }
}


class ATDeviceDetector {
    
    var iPhone: Bool {
        
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    var ipad : Bool{
        
        return UIDevice().userInterfaceIdiom == .pad
    }
    
    let isRetina = UIScreen.main.scale >= 2.0
    
    
    enum ScreenType: String {
        
        case iPhone4
        case iPhone5
        case iPhone6AndIphone7
        case iPhone6PAndIPhone7P
        case iPhoneX
        
        case iPadMini
        case iPadPro
        case iPadPro10Inch
        
        case iPhoneOrIPadSmallSizeUnknown
        case iPadUnknown
        case unknown
    }
    
    
    struct ScreenSize{
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT)
    }
    
    
    var screenType: ScreenType {
        
        switch ScreenSize.SCREEN_MAX_LENGTH {
            
        case 0..<568.0:
            return .iPhone4
        case 568.0:
            return .iPhone5
        case 667.0:
            return .iPhone6AndIphone7
        case 736.0:
            return .iPhone6PAndIPhone7P
        case 812.0:
            return .iPhoneX
        case 568.0..<812.0:
            return .iPhoneOrIPadSmallSizeUnknown
        case 1112.0:
            return .iPadPro10Inch
        case 1024.0:
            return .iPadMini
        case 1366.0:
            return .iPadPro
        case 812.0..<1366.0:
            return .iPadUnknown
        default:
            return .unknown
        }
    }
}

enum FontName : String {
    case light =  "Poppins-Light"
    case bold = "Poppins-Bold"
    case semibold = "Poppins-SemiBold"
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    
    
 }
