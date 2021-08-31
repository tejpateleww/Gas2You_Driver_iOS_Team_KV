//
//  ThemeShadow.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(view: UIView, shadowColor: UIColor?) {
        
        view.layer.shadowColor = shadowColor?.cgColor ?? UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        
    }
    func NavaddShadow(view: UIView, shadowColor: UIColor?) {
        
        view.layer.shadowColor = shadowColor?.cgColor ?? UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        
    }
    
    func addPaticularCornerRadius(view: UIView, cornerRadius: CGFloat) {
        
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, // Top left
            .layerMinXMaxYCorner , // Bottom left
            .layerMaxXMaxYCorner , // Top right
            .layerMaxXMinYCorner // Bottom right
        ]
        view.layer.cornerRadius = cornerRadius
        
    }
    
}

extension UIView{
    ///cornerRadius: CGFloat = 15.0, themeColor: UIColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)
    public func addSoftUIEffectForView(yellowBG : Bool) {
        self.layer.cornerRadius = 10//self.frame.height/2
        self.layer.masksToBounds = false
        //        self.layer.shadowRadius = 2
        //        self.layer.shadowOpacity = 1
        //        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        //        self.layer.shadowColor = UIColor.black.cgColor//UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 1.0).cgColor
        
        self.layer.shadowColor = UIColor.yellow.cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.backgroundColor = UIColor(hexString: "#303030").cgColor// UIColor.gray.cgColor//themeColor.cgColor
        shadowLayer.shadowColor = UIColor(white: 1, alpha: 0.2).cgColor
        shadowLayer.cornerRadius = 10 // self.frame.height/2
        //        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        //        shadowLayer.shadowOpacity = 1
        //        shadowLayer.shadowRadius = 2
        
        if yellowBG {
            shadowLayer.backgroundColor = UIColor(hexString: "#FECD00").cgColor
        }
        
        
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear, // curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                        
                       }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                           }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
                       }
    }
    
    func translationAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0,
                       delay: 0,
                       options: .curveLinear, // curveLinear,
                       animations: { [weak self] in
                        //                        self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                        //                        self?.transform = CGAffineTransform.init(translationX: 0, y: (self?.frame.height)!)
                        
                       }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .autoreverse,
                           animations: { [weak self] in
                            //                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                            
                            //                            self?.transform = CGAffineTransform.init(translationX: 0, y: -(self?.frame.height)!)
                           }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
                       }
    }
    
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = shakeCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
        self.layer.add(animation, forKey: "shake")
    }
    
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

