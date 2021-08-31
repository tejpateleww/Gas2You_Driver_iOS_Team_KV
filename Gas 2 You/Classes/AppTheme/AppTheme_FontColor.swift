//
//  AppTheme_FontColor.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit

var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)


enum ThemeColor: String {
    case themeColorForButton = "#9B51E0"
    
    case ThemePlaceHolderTextColor = "#B2B2BE"
    
    
    case themeButtonBlue = "1F1F3F"
    
    
    case themeSplashTitle = "838487"
    case themeBlue = "1C75BB"
    case themeSolidGray = "303030"
    case themeRed = "E24444"
    case themeGreen = "43D87F"
    
    
    ///FirstGradient is themeGold
    case themeGradientSecond = "9F892A"
    case themeBorderGray = "F6F6F6"
    case themeGrayText = "D6D6D6"
    case ThemeGradientBlack1 = "434343"
    case themeLightGrayText = "707070"
    //case ThemeGradientBlack2 = "303030"
    case themeLightBG = "2E2E2E"
    case themeDarkGray = "2A2A2A"
}



enum FontSize : CGFloat {
    
    case size8 = 8.0
    case size10 = 10.0
    case size12 = 12.0
    case size13 = 13.0
    case size14 = 14.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size19 = 19.0
    case size20 = 20.0
    case size22 = 22.0
    case size24 = 24.0
}

enum FontBook: String {
    
    case light =  "Poppins-Light"
    case bold = "Poppins-Bold"
    case semibold = "Poppins-SemiBold"
    case regular = "Poppins-Regular"
    
    
    func of(size: CGFloat) -> UIFont {
        //        return UIFont(name:self.rawValue, size: manageFont(font: size))!
        return UIFont(name:self.rawValue, size: size) ?? UIFont.systemFont(ofSize: 15)
    }
    
    //    func manageFont(font : CGFloat) -> CGFloat {
    //        let cal  = SCREEN_HEIGHT * font
    //        return CGFloat(cal / CGFloat(screenHeightDeveloper))
    //    }
    
    
    func staticFont(size : CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    func setlabelFont(labels:[UILabel] , Size:CGFloat , TextColour:UIColor) {
        for label in labels{
            label.font = staticFont(size: Size)
            label.textColor = TextColour
        }
    }
    
}



extension UIColor {

    static func appColor(_ name: ThemeColor) -> UIColor {
        switch name {

        case .themeButtonBlue:
            return UIColor(hexString: ThemeColor.themeButtonBlue.rawValue)
        case .themeBlue:
            return UIColor(hexString: ThemeColor.themeBlue.rawValue)
        case .themeSolidGray:
            return UIColor(hexString: ThemeColor.themeSolidGray.rawValue)
        case .themeRed:
            return  UIColor(hexString: ThemeColor.themeRed.rawValue)
        case .themeGreen:
            return  UIColor(hexString: ThemeColor.themeGreen.rawValue)
        case .themeGradientSecond:
            return  UIColor(hexString: ThemeColor.themeGradientSecond.rawValue)
        case .themeGrayText:
            return  UIColor(hexString: ThemeColor.themeGrayText.rawValue)
        case .themeBorderGray:
            return  UIColor(hexString: ThemeColor.themeBorderGray.rawValue)
        case .ThemeGradientBlack1:
            return  UIColor(hexString: ThemeColor.ThemeGradientBlack1.rawValue)
        case .themeLightGrayText:
            return  UIColor(hexString: ThemeColor.themeLightGrayText.rawValue)
        case .themeLightBG:
            return  UIColor(hexString: ThemeColor.themeLightBG.rawValue)
        case .themeDarkGray:
            return  UIColor(hexString: ThemeColor.themeDarkGray.rawValue)
        case .themeSplashTitle:
            return  UIColor(hexString: ThemeColor.themeDarkGray.rawValue)
        case .ThemePlaceHolderTextColor:
            return  UIColor(hexString: ThemeColor.ThemePlaceHolderTextColor.rawValue)
        case .themeColorForButton:
            return  UIColor(hexString: ThemeColor.themeColorForButton.rawValue)
        }
    }


}

