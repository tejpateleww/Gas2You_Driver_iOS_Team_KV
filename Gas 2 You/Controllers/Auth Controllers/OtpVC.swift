//
//  OtpVC.swift
//  Gas 2 You Driver
//
//  Created by Tej on 02/09/21.
//

import UIKit

class OtpVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak private var txtFldOTP1: SingleDigitField!
    @IBOutlet weak private var txtFldOTP2: SingleDigitField!
    @IBOutlet weak private var txtFldOTP3: SingleDigitField!
    @IBOutlet weak private var txtFldOTP4: SingleDigitField!
    @IBOutlet weak var btnResend: themeButton!
    @IBOutlet weak var lblCheckEmail: themeLabel!
    @IBOutlet weak var lblTimer: themeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    
    var strOtp = ""
    var timer = Timer()
    var counter = 30
    var arrTextFields : [UITextField] = []
    
    var otpUserModel = OTPUserModel()
    var registerReqModel : RegisterRequestModel?
    var locationManager : LocationService?
    
    //MARK:- Life Cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "OTP Verification", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.setupBottomBorder()
    }
    
    //MARK:- custom methods
    func prepareView() {
        
        let email = registerReqModel?.email ?? ""
        let components = email.components(separatedBy: "@")
        let result = self.hideMidChars(components.first!) + "@" + components.last!
        
        self.lblCheckEmail.text = "Check your email address. We've sent you the code at \(result)"
        self.arrTextFields = [txtFldOTP1, txtFldOTP2, txtFldOTP3, txtFldOTP4]
        
        self.txtFldOTP1.isUserInteractionEnabled = true
        self.arrTextFields.forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        
        self.otpToastDisplay()
        self.reversetimer()
        
    }
    
    func setupBottomBorder() {
        self.txtFldOTP1.addBottomBorder()
        self.txtFldOTP2.addBottomBorder()
        self.txtFldOTP3.addBottomBorder()
        self.txtFldOTP4.addBottomBorder()
    }
    
    func reversetimer(){
        self.timer.invalidate() // just in case this button is tapped multiple times
        self.lblTimer.isHidden = false
        self.btnResend.isUserInteractionEnabled = false
        self.btnResend.setTitleColor(#colorLiteral(red: 0.1215686275, green: 0.5411764706, blue: 0.7803921569, alpha: 1).withAlphaComponent(0.7), for: .normal)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func hideMidChars(_ value: String) -> String {
        return String(value.enumerated().map { index, char in
            return [0, 1, value.count, value.count].contains(index) ? char : "*"
        })
    }
    
    func otpToastDisplay(){
        Utilities.showAlert(UrlConstant.OTPSent, message: self.strOtp, vc: self)
    }
    
    func getLocation() -> Bool {
        if Singleton.sharedInstance.userCurrentLocation == nil{
            self.locationManager = LocationService()
            self.locationManager?.startUpdatingLocation()
            return false
        }else{
            return true
        }
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func timerAction() {
        if self.counter > 0{
            self.counter -= 1
            self.lblTimer.text =  self.counter > 9 ? "00:\(self.counter)" : "00:0\(self.counter)"
        } else {
            self.lblTimer.isHidden = true
            self.btnResend.isUserInteractionEnabled = true
            self.btnResend.setTitleColor(#colorLiteral(red: 0.1201425865, green: 0.5393100977, blue: 0.7819268107, alpha: 1), for: .normal)
            self.timer.invalidate()
        }
    }
    
    @objc func editingChanged(_ textField: SingleDigitField) {
        if textField.pressedDelete {
            textField.pressedDelete = false
            if textField.hasText {
                textField.text = ""
            } else {
                switch textField {
                case self.txtFldOTP2, self.txtFldOTP3, self.txtFldOTP4:
                    textField.resignFirstResponder()
                    textField.isUserInteractionEnabled = false
                    switch textField {
                    case self.txtFldOTP2:
                        self.txtFldOTP1.isUserInteractionEnabled = true
                        self.txtFldOTP1.becomeFirstResponder()
                        self.txtFldOTP1.text = ""
                    case self.txtFldOTP3:
                        self.txtFldOTP2.isUserInteractionEnabled = true
                        self.txtFldOTP2.becomeFirstResponder()
                        self.txtFldOTP2.text = ""
                    case self.txtFldOTP4:
                        self.txtFldOTP3.isUserInteractionEnabled = true
                        self.txtFldOTP3.becomeFirstResponder()
                        self.txtFldOTP3.text = ""
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
        case self.txtFldOTP1, self.txtFldOTP2, self.txtFldOTP3:
            textField.resignFirstResponder()
            textField.isUserInteractionEnabled = false
            switch textField {
            case self.txtFldOTP1:
                self.txtFldOTP2.isUserInteractionEnabled = true
                self.txtFldOTP2.becomeFirstResponder()
            case self.txtFldOTP2:
                self.txtFldOTP3.isUserInteractionEnabled = true
                self.txtFldOTP3.becomeFirstResponder()
            case self.txtFldOTP3:
                self.txtFldOTP4.isUserInteractionEnabled = true
                self.txtFldOTP4.becomeFirstResponder()
            default: break
            }
        case self.txtFldOTP4:
            self.txtFldOTP4.resignFirstResponder()
        default: break
        }
    }
    
    // MARK:- button action methods
    @IBAction func btnVerifyAction(_ sender: Any) {
        let strTokenCode = "\(self.txtFldOTP1.text ?? "" )\(self.txtFldOTP2.text ?? "" )\(self.txtFldOTP3.text ?? "" )\(self.txtFldOTP4.text ?? "")"
        if(self.strOtp != strTokenCode){
            Utilities.showAlert(AppName, message: UrlConstant.ValidOtpNo, vc: self)
        }else{
            self.timer.invalidate()
            if self.getLocation(){
                self.callRegisterApi()
            }
        }
    }
    
    @IBAction func btnResendAction(_ sender: Any) {
        for txtfield in arrTextFields{
            txtfield.text = ""
        }
        self.txtFldOTP1.isUserInteractionEnabled = true
        self.counter = 31
        self.callOtpApi()
    }
}


//MARK:- Api Call
extension OtpVC{
    
    func callOtpApi(){
        self.otpUserModel.otpVC = self
        let otpReqModel = OTPRequestModel()
        otpReqModel.email = registerReqModel?.email ?? ""
        self.otpUserModel.webserviceOtp(reqModel: otpReqModel)
    }
    
    func callRegisterApi(){
        self.otpUserModel.otpVC = self
        self.otpUserModel.webserviceRegister(reqModel: self.registerReqModel!)
    }
}
