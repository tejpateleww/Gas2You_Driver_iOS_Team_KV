//
//  Fonts.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit

enum CustomFont
{
    case italic,lightitalic,medium,light,mediumitalic,bold,bolditalic,regular,PoppinsThinItalic,PoppinsBold,PoppinsLight,PoppinsMedium,PoppinsRegular,PoppinsSemiBold,PoppinsItalic,PoppinsLightItalic
    //  PoppinsBlack,PoppinsBlackItalic,,Poppins-BoldItalic,Poppins-ExtraBold,Poppins-ExtraBoldItalic,Poppins-ExtraLight,Poppins-ExtraLightItalic,Poppins-Italic,Poppins-Light,Poppins-LightItalic,Poppins-Medium,Poppins-MediumItalic,Poppins-Regular,Poppins-SemiBold,Poppins-SemiBoldItalic,Poppins-Thin,
    func returnFont(_ font:CGFloat)->UIFont
    {
        switch self
        {
        case .PoppinsThinItalic:
            return UIFont(name: "Poppins-ThinItalic", size: font)!
        case .PoppinsBold:
            return UIFont(name: "Poppins-Bold", size: font)!
        case .PoppinsLight:
            return UIFont(name: "Poppins-Light", size: font)!
        case .PoppinsMedium:
            return UIFont(name: "Poppins-Medium", size: font)!
        case .PoppinsRegular:
            return UIFont(name: "Poppins-Regular", size: font)!
        case .PoppinsSemiBold:
            return UIFont(name: "Poppins-SemiBold", size: font)!
        case .PoppinsItalic:
            return UIFont(name: "Poppins-Italic", size: font)!
        case .PoppinsLightItalic:
            return UIFont(name: "Poppins-LightItalic", size: font)!
        case .italic:
            return UIFont(name: "Poppins-Italic", size: font)!
        case .lightitalic:
            return UIFont(name: "Poppins-ThinItalic", size: font)!
        case .medium:
            return UIFont(name: "Poppins-Medium", size: font)!
        case .light:
            return UIFont(name: "Poppins-Light", size: font)!
        case .mediumitalic:
            return UIFont(name: "Poppins-Italic", size: font)!
        case .bold:
            return UIFont(name: "Poppins-Bold", size: font)!
        case .bolditalic:
            return UIFont(name: "Poppins-Italic", size: font)!
        case .regular:
            return UIFont(name: "Poppins-Regular", size: font)!
        }
    }
}

enum FontsSize
{
    static let ExtraLarge : CGFloat = 40
    static let Large : CGFloat = 33
    static let MediumLarge : CGFloat = 26
    static let Medium : CGFloat = 25
    static let Regular : CGFloat = 18
    static let Small : CGFloat = 16
    static let ExtraSmall : CGFloat = 15
    static let Tiny :CGFloat = 14
}

extension UIFont
{
    class func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Regular", size: size)!
    }
    
    class func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Medium", size: size)!
    }
    
    class func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Bold", size: size)!
    }
}



