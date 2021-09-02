//
//  OtpVC.swift
//  Gas 2 You Driver
//
//  Created by Tej on 02/09/21.
//

import UIKit

class OtpVC: BaseVC {
    
    @IBOutlet weak private var txtFldOTP1: SingleDigitField!
    @IBOutlet weak private var txtFldOTP2: SingleDigitField!
    @IBOutlet weak private var txtFldOTP3: SingleDigitField!
    @IBOutlet weak private var txtFldOTP4: SingleDigitField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "OTP Varification", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        
        [txtFldOTP1, txtFldOTP2, txtFldOTP3, txtFldOTP4].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        txtFldOTP1.isUserInteractionEnabled = true
        txtFldOTP1.becomeFirstResponder()

    }
    
    
    @objc func editingChanged(_ textField: SingleDigitField) {
        if textField.pressedDelete {
            textField.pressedDelete = false
            if textField.hasText {
                textField.text = ""
            } else {
                switch textField {
                case txtFldOTP2, txtFldOTP3, txtFldOTP4:
                    textField.resignFirstResponder()
                    textField.isUserInteractionEnabled = false
                    switch textField {
                    case txtFldOTP2:
                        txtFldOTP1.isUserInteractionEnabled = true
                        txtFldOTP1.becomeFirstResponder()
                        txtFldOTP1.text = ""
                    case txtFldOTP3:
                        txtFldOTP2.isUserInteractionEnabled = true
                        txtFldOTP2.becomeFirstResponder()
                        txtFldOTP2.text = ""
                    case txtFldOTP4:
                        txtFldOTP3.isUserInteractionEnabled = true
                        txtFldOTP3.becomeFirstResponder()
                        txtFldOTP3.text = ""
                    default:
                        break
                    }
                default: break
                }
            }
        }
        
        guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
            textField.text = ""
            return
        }
        switch textField {
        case txtFldOTP1, txtFldOTP2, txtFldOTP3:
            textField.resignFirstResponder()
            textField.isUserInteractionEnabled = false
            switch textField {
            case txtFldOTP1:
                txtFldOTP2.isUserInteractionEnabled = true
                txtFldOTP2.becomeFirstResponder()
            case txtFldOTP2:
                txtFldOTP3.isUserInteractionEnabled = true
                txtFldOTP3.becomeFirstResponder()
            case txtFldOTP3:
                txtFldOTP4.isUserInteractionEnabled = true
                txtFldOTP4.becomeFirstResponder()
            default: break
            }
        case txtFldOTP4:
            txtFldOTP4.resignFirstResponder()
        default: break
        }
    }
    
    @IBAction func btnVerifyAction(_ sender: Any) {
        let strTokenCode = "\(self.txtFldOTP1.text ?? "" )\(self.txtFldOTP2.text ?? "" )\(self.txtFldOTP3.text ?? "" )\(self.txtFldOTP4.text ?? "")"
        print(strTokenCode)
        appDel.navigateToHome()
    }
    


}
