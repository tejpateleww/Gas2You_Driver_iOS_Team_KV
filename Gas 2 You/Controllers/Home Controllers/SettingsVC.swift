//
//  SettingsVC.swift
//  Gas 2 You
//
//  Created by MacMini on 10/08/21.
//

import UIKit

class SettingsVC: BaseVC {

    @IBOutlet weak var switchNotification: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: "Settings", leftImage: "Back", rightImages: [], isTranslucent: true)
        switchNotification.layer.cornerRadius = switchNotification.bounds.height/2
        switchNotification.layer.borderWidth = 1
        switchNotification.layer.borderColor = #colorLiteral(red: 0.1801939905, green: 0.8354453444, blue: 0.6615549922, alpha: 1)
//        NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "Settings", controller: self)
    }
    
    @IBAction func btnPrivacyTap(_ sender: Any) {
        
    }
    @IBAction func btnLogoutTap(_ sender: UIButton) {
        
        SettingsVC.showAlertWithTitleFromVC(vc: self, title: "Logout", message: "Are you sure want to Logout?", buttons: ["Cancel", "Logout"]) { index in
            if index == 1 {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                AppDel.navigateToLogin()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
