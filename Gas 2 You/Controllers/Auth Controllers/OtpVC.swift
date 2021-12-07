//
//  OtpVC.swift
//  Gas 2 You Driver
//
//  Created by Tej on 02/09/21.
//

import UIKit
import OTPFieldView

class OtpVC: BaseVC {
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnResend: themeButton!
    @IBOutlet weak var lblCheckEmail: themeLabel!
    @IBOutlet weak var lblTimer: themeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    
    var strOtp = ""
    var strEnteredOtp = ""
    var strEmail = ""
    var hasEnteredAllOTP:Bool = false
    var timer = Timer()
    var counter = 30
    var countOfAstric = 0
    var arrTextFields : [UITextField] = []
    
    var otpUserModel = OTPUserModel()
    var registerReqModel : RegisterRequestModel?
    var locationManager : LocationService?
    
    //MARK: - Life Cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "OTP Verification", leftImage: "Back", rightImages: [], isTranslucent: true, iswhiteTitle: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupOtpView()
        self.prepareView()
    }
    
    //MARK: - custom methods
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.white
        self.otpTextFieldView.filledBorderColor = UIColor.white
        self.otpTextFieldView.cursorColor = UIColor.white
        self.otpTextFieldView.errorBorderColor = UIColor.red
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = 60
        self.otpTextFieldView.separatorSpace = 15
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    
    func prepareView() {
        let email = registerReqModel?.email ?? ""
        let components = email.components(separatedBy: "@")
        
        if(components.first?.count ?? 0 <= 2){
            self.strEmail = registerReqModel?.email ?? ""
        }else{
            self.strEmail = self.hideMidChars(components.first!) + "@" + components.last!
            
            print(self.strEmail.countInstances(of: "*"))
            self.countOfAstric = self.strEmail.countInstances(of: "*")
            if(self.countOfAstric != 5){
                self.replaceEmail()
            }
        }
        
        self.lblCheckEmail.text = "Check your email address. We've sent you the code at \(self.strEmail)"
        self.otpToastDisplay()
        self.reversetimer()
    }
    
    func replaceEmail(){
        self.countOfAstric = self.strEmail.countInstances(of: "*")
        if(self.countOfAstric == 5){return}
        
        if(self.countOfAstric < 5){
            self.strEmail = self.strEmail.replaceCharacter(oldCharacter: "*", newCharacter: "**")
            self.replaceEmail()
        }else{
            self.strEmail = self.strEmail.replacingLastOccurrenceOfString("*", with: "")
            self.replaceEmail()
        }
    }
    
    func reversetimer(){
        self.timer.invalidate()
        self.lblTimer.isHidden = false
        self.btnResend.setTitle("Resend code in", for: .normal)
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
        //Utilities.showAlert(UrlConstant.OTPSent, message: self.strOtp, vc: self)
    }
    
    func clearAllFields(){
        self.otpTextFieldView.initializeUI()
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
            self.btnResend.setTitle("Resend code", for: .normal)
            self.btnResend.isUserInteractionEnabled = true
            self.btnResend.setTitleColor(#colorLiteral(red: 0.1201425865, green: 0.5393100977, blue: 0.7819268107, alpha: 1), for: .normal)
            self.timer.invalidate()
        }
    }
    
    // MARK: - button action methods
    @IBAction func btnVerifyAction(_ sender: Any) {
        
        if(self.hasEnteredAllOTP){
            if(self.strOtp != self.strEnteredOtp){
                Toast.show(title: UrlConstant.Required, message: UrlConstant.ValidOtpNo, state: .info)
            }else{
                self.timer.invalidate()
                if self.getLocation(){
                    self.callRegisterApi()
                }
            }
        }else{
            Toast.show(title: UrlConstant.Required, message: UrlConstant.ValidOtpNo, state: .info)
        }
    }
    
    @IBAction func btnResendAction(_ sender: Any) {
        
        
        self.counter = 31
        self.callOtpApi()
    }
}


//MARK: - Api Call
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

//MARK: - OTPFieldView
extension OtpVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        self.hasEnteredAllOTP = hasEntered
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.strEnteredOtp = otpString
    }
}
