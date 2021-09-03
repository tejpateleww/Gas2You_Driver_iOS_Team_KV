//
//  SplashVC.swift
//  Gas 2 You Driver
//
//  Created by Tej on 31/08/21.
//

import UIKit
import CoreLocation

class SplashVC: UIViewController {
    
    //MARK:- Variables
    var locationManager: CLLocationManager?
    
    //MARK:- Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = userDefaults.getUserData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.webserviceInit()
        }
    }
    
}

//MARK:- Apis
extension SplashVC{
    func webserviceInit(){
        WebServiceSubClass.InitApi { (status, message, response, error) in
            if let dic = error as? [String: Any], let msg = dic["message"] as? String, msg == UrlConstant.NoInternetConnection || msg == UrlConstant.SomethingWentWrong || msg == UrlConstant.RequestTimeOut{
                Utilities.showAlertWithTitleFromVC(vc: self, title: AppName, message: msg, buttons: [UrlConstant.Retry], isOkRed: false) { (ind) in
                    self.webserviceInit()
                }
                return
            }
            
            if status {
                Singleton.sharedInstance.AppInitModel = response
                if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                    Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: message, buttons: [UrlConstant.Ok,UrlConstant.Cancel]) { (ind) in
                        if ind == 0{
                            if let url = URL(string: AppURL) {
                                UIApplication.shared.open(url)
                            }
                        }else {
                            self.setRootViewController()
                        }
                    }
                }else{
                    self.setRootViewController()
                }
            }else{
                if let responseDic = error as? [String:Any], let _ = responseDic["maintenance"] as? Bool{
                    Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: message, buttons: []) {_ in}
                }else{
                    if let responseDic = error as? [String:Any], let _ = responseDic["update"] as? Bool{
                        self.openForceUpdateAlert(msg: message)
                    }else{
                        Utilities.showAlertOfAPIResponse(param: error, vc: self)
                    }
                }
            }
            
            //Location Update
            let status = CLLocationManager.authorizationStatus()
            if(status == .authorizedAlways || status == .authorizedWhenInUse){
                appDel.locationService.startUpdatingLocation()
            }
        }
    }
}

//MARK:- Common Methods
extension SplashVC{
    func openForceUpdateAlert(msg: String){
        Utilities.showAlertWithTitleFromWindow(title: AppName, andMessage: msg, buttons: [UrlConstant.Ok]) { (ind) in
            if ind == 0{
                if let url = URL(string: AppURL) {
                    UIApplication.shared.open(url)
                }
                self.openForceUpdateAlert(msg: msg)
            }
        }
    }
    
    func setRootViewController() {
        let isLogin = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLogin.rawValue)
        if isLogin, let _ = userDefaults.getUserData() {
            appDel.navigateToHome()
        }else{
            appDel.navigateToLogin()
        }
    }
}
