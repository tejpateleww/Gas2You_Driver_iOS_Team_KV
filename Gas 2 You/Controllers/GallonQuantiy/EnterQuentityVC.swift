//
//  EnterQuentityVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 12/08/21.
//

import UIKit

class EnterQuentityVC: BaseVC{
    
    //MARK:-IBOutlets
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var txtPrice: themeTextfield!
    @IBOutlet weak var lblGallon: themeLabel!
    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var btnCancel: ThemeButton!
    @IBOutlet weak var lblEnterQuentity: themeLabel!
    
    //MARK:- Variables
    var btnSubmitClosure : ((String)->())?
    var Quantity :String = ""
    let ACCEPTABLE_CHARACTERS_FOR_QUANTITY = "0123456789."
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
    }
    
    //MARK:- Custom Methods
    func prepareView(){
        self.vwMain.layer.cornerRadius = 20
        self.vwMain.layer.masksToBounds = true
        
        if(self.Quantity != ""){
            let Gallon: String = self.Quantity
            let words = Gallon.components(separatedBy: " ")
            self.txtPrice.text = words[0]
        }
    }
    
    
    
    //MARK:- IBActions
    @IBAction func btnSubmitTap(_ sender: Any) {
        if(self.txtPrice.text == ""){
            Utilities.showAlert("Gas2You", message: "Please enter quantity", vc: self)
            return
        }
        if(self.txtPrice.text?.last == "."){
            self.txtPrice.text = String((self.txtPrice.text?.dropLast())!)
        }
        self.dismiss(animated: false, completion: {
            if let obj = self.btnSubmitClosure{
                obj((self.txtPrice.text ?? "0.0") + " Gallon")
            }
        })
    }
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}


//MARK:- TextField Delegate
extension EnterQuentityVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        if (textField.text?.count == 0 && string == "0") || (textField.text?.count == 0 && string == "."){
            return false
        }
        
        if (textField.text?.contains("."))! && string == "." {
            return false
        }
        
        if (textField.text?.contains("."))! {
            let limitDecimalPlace = 3
            let decimalPlace = textField.text?.components(separatedBy: ".").last
            if (decimalPlace?.count)! < limitDecimalPlace {
                return true
            }
            else {
                return false
            }
        }
        
        switch textField {
        
        case self.txtPrice :
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_FOR_QUANTITY).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            let currentString: NSString = textField.text as NSString? ?? ""
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return (string == filtered) ? (newString.length <= MAX_QUANTITY_DIGITS) : false
            
        default:
            print("")
        }
        
        return true
    }
}
