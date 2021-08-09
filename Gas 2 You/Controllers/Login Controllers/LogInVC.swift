//
//  LogInVC.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstTF: themeTextfield!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func logInButtonPreesed(_ sender: ThemeButton) {
        
        let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
        navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: themeButton) {
        
        let signUpVC = storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}
