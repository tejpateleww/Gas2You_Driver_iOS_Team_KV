//
//  LogInVC.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var txtEmail: themeTextfield!
    @IBOutlet weak var txtPassword: themeTextfield!
    @IBOutlet weak var btnSignUp: themeButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfields(textfield: txtPassword)
        btnSignUp.setunderline(title: btnSignUp.titleLabel?.text ?? "", color: .white, font: CustomFont.PoppinsSemiBold.returnFont(16))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    func setupTextfields(textfield : UITextField) {
        
        textfield.rightViewMode = .always
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
        button.setTitle("Forgot?", for: .normal)
        button.setColorFont(color: .gray , font: CustomFont.PoppinsMedium.returnFont(14))
        button.addTarget(self, action: #selector(navigateToForgotPassword), for: .touchUpInside)
        let view = UIView(frame : CGRect(x: 0, y: 0, width: 80, height: 40))
        view.addSubview(button)
        textfield.rightView = view
        
    }
    
    @objc func navigateToForgotPassword(){
        let loginStory = UIStoryboard(name: "Main", bundle: nil)
        let forgotpassVC = loginStory.instantiateViewController(identifier: ForgotPasswordVC.className) as! ForgotPasswordVC
        navigationController?.pushViewController(forgotpassVC, animated: true)
    }
    
    @IBAction func logInButtonPreesed(_ sender: ThemeButton) {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        AppDel.navigateToHome()
    }
    
    @IBAction func signUpButtonPressed(_ sender: themeButton) {
        
        let signUpVC = storyboard?.instantiateViewController(identifier: SignUpVC.className) as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}
