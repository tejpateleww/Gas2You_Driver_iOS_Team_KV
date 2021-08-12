//
//  LogInVC.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstTF: themeTextfield!
    @IBOutlet weak var btnSignUp: themeButton!
    @IBOutlet weak var btnLogin: ThemeButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func logInButtonPreesed(_ sender: ThemeButton) {
        
//        let homeVC = storyboard?.instantiateViewController(identifier: HomeVC.className) as! HomeVC
//        navigationController?.pushViewController(homeVC, animated: true)
        
        let vc : SendInvoiceVC = SendInvoiceVC.instantiate(fromAppStoryboard: .Main)
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: themeButton) {
        
        let signUpVC = storyboard?.instantiateViewController(identifier: SignUpVC.className) as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}
