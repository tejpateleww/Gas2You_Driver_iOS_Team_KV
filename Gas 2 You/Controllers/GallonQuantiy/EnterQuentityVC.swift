//
//  EnterQuentityVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 12/08/21.
//

import UIKit

class EnterQuentityVC: BaseVC,UITextFieldDelegate{
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true
        
        if(self.Quantity != ""){
            let Gallon: String = self.Quantity
            let words = Gallon.components(separatedBy: " ")
            self.txtPrice.text = words[0]
        }
//        txtPrice.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- IBActions
    @IBAction func btnSubmitTap(_ sender: Any) {
        if(self.txtPrice.text == ""){
            Utilities.showAlert("Gas2You", message: "Please enter quantity", vc: self)
            return
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.StopWrittingAtCharactorLimit(CharLimit: 6, range: range, string: string)
    }
    @objc func myTextFieldDidChange(_ textField: UITextField) {

        if let amountString = textField.text?.currencyInputFormatting(textfield: txtPrice) {
            txtPrice.text = amountString
            lblGallon.isHidden = txtPrice.text == "" ? true : false
        }
    }
}
extension String {

    // formatting text for currency textField
    func currencyInputFormatting(textfield : UITextField) -> String {

        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""//SingletonClass.sharedInstance.currency
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, textfield.text?.count ?? 0), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 1000))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
}
