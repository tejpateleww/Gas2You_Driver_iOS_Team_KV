//
//  SplashVC.swift
//  Gas 2 You Driver
//
//  Created by Tej on 31/08/21.
//

import UIKit

class SplashVC: UIViewController {
    
    private var isApiResponseDone = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
            AppDel.navigateToLogin()
        } else {
            AppDel.navigateToHome()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
