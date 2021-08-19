//
//  SignUpVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit

class SignUpVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var txtFirstName: themeTextfield!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtMobile: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var txtConfirmPassword: themeTextfield!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnLoginNow: themeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupTextfields(textfield: txtEmail)
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "", leftImage: "Back", rightImages: [], isTranslucent: true)
        btnLoginNow.setunderline(title: btnSignUp.titleLabel?.text ?? "", color: .white, font: CustomFont.PoppinsSemiBold.returnFont(16))
        
        //mobile no field +1 related code
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        txtMobile.leftView = paddingView
        txtMobile.leftViewMode = .always
        txtMobile.layer.borderWidth = 1
        txtMobile.layer.borderColor = UIColor.white.cgColor
        txtMobile.layer.cornerRadius = 8
    }
    
    //MARK:- Custom Methods
    
    func setupTextfields(textfield : UITextField) {
        let button = UIButton(type: .custom)
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "IC_selectedCheckGray"), for: .normal)
        //        button.setImage(UIImage(named: "hidepassword"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tag = textfield.tag
        //        button.addTarget(self, action: #selector(self.showHidePassword), for: .touchUpInside)
        textfield.rightView = button
        textfield.rightViewMode = .always
    }
    
    //MARK:- IBAction
    @IBAction func btnPrivacyPolicyTap(_ sender: Any) {
        
    }
    
    @IBAction func btnLoginNowTap(_ sender: Any) {
        
    }
    @IBAction func btnSignupTap(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        AppDel.navigateToHome()
    }
    @IBAction func logInNowButtonPressed(_ sender: themeButton){
        navigationController?.popViewController(animated: true)
    }
}
