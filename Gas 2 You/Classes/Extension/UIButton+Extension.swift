//
//  UIButton+Extension.swift
//  CoreSound
//
//  Created by EWW083 on 04/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
extension UIButton{
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    //MARK:- Text In Two Differnt Color in Button Text
    func setTextColor(str1:String,str2:String,color1:UIColor,color2:UIColor){

        let att = NSMutableAttributedString(string: "\(str1)\(str2)");
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: color1, range: NSRange(location: 0, length: str1.count))
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: color2, range: NSRange(location: str1.count, length: str2.count))
        self.setAttributedTitle(att, for: .normal)
    }
    //MARK:- color and font
    func setColorFont(color: colors, font: UIFont){
        self.setTitleColor(color.value, for: .normal)
        self.titleLabel?.font = font
    }
    //MARK:- text color font
    func setTitleColorFont(title:String ,color: colors, font: UIFont){
        self.setTitleColor(color.value, for: .normal)
        self.setTitle(" \(title) ", for: .normal)
        self.titleLabel?.font = font
    }
    //MARK:- text color font background
    func setTitleColorFontBGColor(title:String ,color: colors, font: UIFont, bgColor: colors){
        self.setTitleColor(color.value, for: .normal)
        self.setTitle(" \(title) ", for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = bgColor.value
    }
    
    func setLeftImage(iconName: String){
        let image = UIImage(named: iconName)
        self.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ((image?.size.width)! / 2 + 4))
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    func setCenterImage(iconName: String){
        let image = UIImage(named: iconName)
        self.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    func setRightImage(iconName:String){
       // let image = UIImage(named: iconName)
        self.contentHorizontalAlignment = .trailing
        self.setImage(UIImage(named: iconName), for: UIControl.State.normal)
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
       
    }
    func setBoarderColor(bcolor:colors){
        self.layer.borderColor  = bcolor.value.cgColor
        self.layer.borderWidth = 1
    }
    func setshowRadius(){
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
    func setunderline(title:String ,color: UIColor, font: UIFont){
        self.setAttributedTitle(NSMutableAttributedString(string: title, attributes:  [.font: font,.foregroundColor: color,.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
    }
}

