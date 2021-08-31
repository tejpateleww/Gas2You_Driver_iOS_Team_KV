//
//  Colors.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit

enum colors{
    case BlueLabelColor,progessBarTintColor,progesBarTrack,white,black,appColor,red,btnColor,tableBg,gradient1,gradient2,lightGrey,coresoundThemeColor,loginText,loginViewColor,submitButtonColor,loginPlaceHolderColor,phoneNumberColor,AddCardTitleColor,seperatorColor,confirmPasswordPlaceHolder,gray,textfieldbordercolor,clearCol,myride,splashtitleColor,buttonNextBackGroundColor,themecolor
    
    var value:UIColor{
        switch self {
        case .BlueLabelColor:
            return UIColor(hexString: "#9154D8")
        case .progessBarTintColor:
            return UIColor(hexString: "#E6E6E6")
        case .progesBarTrack:
            return UIColor(hexString: "#9154D8")
        case .white:
            return UIColor(hexString: "FFFFFF")
        case .black:
            return UIColor.black
        case .textfieldbordercolor:
            return UIColor(hexString: "#F2F2F2")
        case .appColor:
            return UIColor(hexString:"#7357ee")
        //return UIColor(red: 134/255, green: 65/255, blue: 224/255, alpha: 1.0)
        case .btnColor:
            return UIColor(red: 95/255, green: 91/255, blue: 238/255, alpha: 1.0)
        case .red:
            return UIColor.red
        case .tableBg:
            return UIColor(hexString: "#252525")
        case .gray:
            return UIColor(hexString: "#BBBBBB")
        case .gradient1:
            return UIColor(hexString: "#736DFF")
        case .gradient2:
            return UIColor(hexString: "#7C3FE1")
        case .coresoundThemeColor:
            return UIColor(hexString: "#111044")
        case .lightGrey:
            return UIColor(hexString: "#666666")
        case .loginText:
            return UIColor(hexString: "#1C1B1B")
        case .loginViewColor:
            return UIColor(hexString: "#E4E9F2")
        case .submitButtonColor:
            return UIColor(hexString: "#00AA7E")
        case .loginPlaceHolderColor:
            return UIColor(hexString: "#222B45")
        case .phoneNumberColor:
            return UIColor(hexString: "#8F9BB3")
        case .AddCardTitleColor:
            return UIColor(hexString: "#8992A3")
        case .seperatorColor:
            return UIColor(hexString: "#000000").withAlphaComponent(0.03)
        case .confirmPasswordPlaceHolder:
            return UIColor(hexString: "#8F9BB3")
        case .clearCol:
            return UIColor.clear
        case .myride:
            return UIColor(hexString: "#F7F9FC")
        case .splashtitleColor:
            return UIColor(hexString: "838487")
        case .buttonNextBackGroundColor:
            return UIColor(hexString: "1F1F3F")
        case .themecolor:
            return UIColor(hexString: "1C75BB")
            
        }
    }
}

