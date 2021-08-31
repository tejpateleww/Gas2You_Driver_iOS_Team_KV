//
//  NavigationController.swift
//  CoreSound
//
//  Created by EWW083 on 05/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit

class NavigationController:UINavigationController {
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .lightContent
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23),NSAttributedString.Key.foregroundColor:UIColor.clear]
        self.navigationBar.titleTextAttributes = attributes
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = .clear
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.isTranslucent = true
    }
    
 
}

