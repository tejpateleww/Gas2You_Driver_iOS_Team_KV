//
//  MyProfileVC.swift
//  Gas 2 You
//
//  Created by MacMini on 10/08/21.
//

import UIKit

class MyProfileVC: BaseVC {

    @IBOutlet weak var btnChangePassword: ThemeButton!
    @IBOutlet weak var btnEditProfileTap: ThemeButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtPhone: themeTextfield!
    @IBOutlet weak var vwProfile: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwProfile.layer.cornerRadius = vwProfile.frame.height/2
        vwProfile.addShadow()
        setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: "My Profile", leftImage: "Back", rightImages: [], isTranslucent: true)
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        btnChangePassword.layer.cornerRadius = 9
        btnChangePassword.layer.borderWidth = 2
        btnChangePassword.layer.borderColor = UIColor.init(hexString: "#1C75BB").cgColor
        btnChangePassword.backgroundColor = .white
        btnEditProfileTap.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.4588235294, blue: 0.7333333333, alpha: 0.19)
        btnEditProfileTap.layer.cornerRadius = btnEditProfileTap
            .frame.height/2
        btnEditProfileTap.layer.borderWidth = 2
        btnEditProfileTap.layer.borderColor = UIColor.init(hexString: "#1C75BB").cgColor
        
        txtName.fontColor = .black
        txtEmail.fontColor = .black
        txtPhone.fontColor = .black
//        changePassButton.layer.borderColor = UIColor.appColor(.themeBlue).cgColor
//        btnChangePassword.titleLabel?.font = CustomFont.PoppinsMedium.returnFont(14)
//        changePassButton.setTitleColor(UIColor.appColor(.themeBlue), for: .normal)
    }
    
    @IBAction func btnChangePasswordTap(_ sender: Any) {
        let vc : ChangePasswordVC = ChangePasswordVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnMyEarningTap(_ sender: Any) {
        let vc : MyEarningsVC = MyEarningsVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
