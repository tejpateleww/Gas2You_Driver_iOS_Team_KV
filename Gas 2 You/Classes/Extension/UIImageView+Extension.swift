//
//  UIImageView+Extension.swift
//  Qwnched-Customer
//
//  Created by Hiral's iMac on 16/10/20.
//  Copyright © 2020 Hiral's iMac. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}


extension UIView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

extension UIView {

/// Remove UIBlurEffect from UIView
func removeBlurEffect() {
   let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
   blurredEffectViews.forEach{ blurView in
    blurView.removeFromSuperview()
  }
}
}

