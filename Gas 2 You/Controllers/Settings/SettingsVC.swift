//
//  SettingsVC.swift
//  Gas 2 You
//
//  Created by MacMini on 10/08/21.
//

import UIKit
import SafariServices

class SettingsVC: BaseVC {

    //MARK:- IBOutlet
    @IBOutlet weak var switchNotification: UISwitch!
    
    //MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
    }
    
    //MARK:- Custom methods
    func prepareView(){
        self.setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: "Settings", leftImage: "Back", rightImages: [], isTranslucent: true)
        
        self.switchNotification.layer.cornerRadius = self.switchNotification.bounds.height/2
        self.switchNotification.layer.borderWidth = 1
        self.switchNotification.layer.borderColor = #colorLiteral(red: 0.1801939905, green: 0.8354453444, blue: 0.6615549922, alpha: 1)
        self.switchNotification.tintColor = UIColor(hexString: "#EBFBF6")
    }
    
    func previewDocument(strURL : String){
        guard let url = URL(string: strURL) else {return}
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    //MARK:- Button Action methods
    @IBAction func btnPrivacyTap(_ sender: Any) {
        var PrivacyPolicy = ""
        if let PrivacyPolicyLink = Singleton.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "privacy_policy"}) {
            if PrivacyPolicyLink.count > 0 {
                PrivacyPolicy = PrivacyPolicyLink[0].url ?? ""
                self.previewDocument(strURL: PrivacyPolicy)
            }
        }
    }
    
    @IBAction func btnAboutUsAction(_ sender: Any) {
        var AboutUs = ""
        if let AboutUSLink = Singleton.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "about_us"}) {
            if AboutUSLink.count > 0 {
                AboutUs = AboutUSLink[0].url ?? ""
                self.previewDocument(strURL: AboutUs)
            }
        }
    }
    
    @IBAction func btnTCAction(_ sender: Any) {
        var TC = ""
        if let TCLink = Singleton.sharedInstance.AppInitModel?.appLinks?.filter({ $0.name == "terms_and_condition"}) {
            if TCLink.count > 0 {
                TC = TCLink[0].url ?? ""
                self.previewDocument(strURL: TC)
            }
        }
    }
    
    @IBAction func btnLogoutTap(_ sender: UIButton) {
        SettingsVC.showAlertWithTitleFromVC(vc: self, title: "Logout", message: "Are you sure want to Logout?", buttons: ["Cancel", "Logout"]) { index in
            if index == 1 {
                AppDel.dologout()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
