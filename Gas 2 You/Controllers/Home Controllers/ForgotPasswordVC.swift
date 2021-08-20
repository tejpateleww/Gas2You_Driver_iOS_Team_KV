//
//  ForgotPasswordVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class ForgotPasswordVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

//        NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "Forgot Password", controller: self)
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Forgot Password", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func btnSubmitTap(_ sender: ThemeButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
