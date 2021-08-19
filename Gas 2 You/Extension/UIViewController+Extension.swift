//
//  UIViewController+Extension.swift
//  Qwnched-Delivery
//
//  Created by EWW074 - Sj's iMAC on 26/08/20.
//  Copyright © 2020 EWW074. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    static var className : String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    
    //MARK:- SET_ALERT
    static func showAlertWithTitleFromVC(vc:UIViewController, title:String?, message:String?, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void{

    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count {

    let action = UIAlertAction(title: buttons[index], style: .default, handler: { (alert: UIAlertAction!) in
    if(completion != nil) {
    completion(index)
    }
    })
    alertController.addAction(action)
    }
    DispatchQueue.main.async {
    vc.present(alertController, animated: true, completion: nil)
    }
    }
    
    
    // MARK: IS SWIPABLE - FUNCTION
    func isSwipable(view:UIView) {
         //self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrage(_:))))
         view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:))))
        
        //self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    // MARK:  swipe down to hide - FUNCTION
    
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                print(">0",touchPoint)
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                print(">100",touchPoint)
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    //MARK: ====ALERT

    ///Pass "" if you dont want a cancel button , 0 : OK , 1:Cancel
    func showAlertWithTwoButtonCompletion(title:String, Message:String, defaultButtonTitle:String, cancelButtonTitle : String? = "",  Completion:@escaping ((Int) -> ())) {
        
        let alertController = UIAlertController(title: title , message:Message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: defaultButtonTitle, style: .default) { (UIAlertAction) in
            Completion(0)
        }
        if cancelButtonTitle != ""{
            let CancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (UIAlertAction) in
                Completion(1)
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
        }else{
            alertController.addAction(OKAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: ====Activity indicator
    func showHUD() {
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.appColor(ThemeColor.themeBlue)
        activityIndicator.tag = 1001
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func hideHUD() {
        let activityIndicator = self.view.viewWithTag(1001) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    //MARK: ====Location Alert
 
    
    class func alertForLocation(currentVC : UIViewController){
        
        let alertController = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success)
                    
                    in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        
        alertController.addAction(OKAction)
        OperationQueue.main.addOperation {
            currentVC.present(alertController, animated: true,
                              completion:nil)
        }
    }
    
    
    
    func addNavBarImage(isLeft:Bool, isRight:Bool) {
        if isLeft {
           
             if DeviceType.hasTopNotch {
                let w = 114
                let h = 51
                let img1 = UIImageView(frame: CGRect(x: 12, y: 40, width: w, height: h))
                img1.image = UIImage(named: "imgLogo.png")
                self.view.addSubview(img1)
             }else {
                let w = 100
                let h = 41
                let img = UIImageView(frame: CGRect(x: 12, y: 25, width: w, height: h))
                img.image = UIImage(named: "imgLogo.png")
                self.view.addSubview(img)
             }
           
            
//            img.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//            img.heightAnchor.constraint(equalToConstant: 106).isActive = true
//            img.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            
        }
        if isRight {
//            var w = 90
//            var h = 25
//            if DeviceType.hasTopNotch {
//                w = 110
//                h = 40
            var w = 105
            var h = 70
            if DeviceType.hasTopNotch {
                w = 125
                h = 95
            }
            let img = UIImageView(frame: CGRect(x: Int(self.view.frame.size.width) - w, y: 0, width: w, height: h))
            img.image = UIImage(named: "imgNavBar.png")
            self.view.addSubview(img)
//            img.translatesAutoresizingMaskIntoConstraints = false
//            img.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//            img.heightAnchor.constraint(equalToConstant: 40).isActive = true
//            img.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            
        }
    }
    
    
}

private func _swizzling(forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
     if let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
         method_exchangeImplementations(originalMethod, swizzledMethod)
     }
 }


  extension UIViewController {

      static let preventPageSheetPresentation: Void = {
          if #available(iOS 13, *) {
              _swizzling(forClass: UIViewController.self,
                         originalSelector: #selector(present(_: animated: completion:)),
                         swizzledSelector: #selector(_swizzledPresent(_: animated: completion:)))
          }
      }()

      @available(iOS 13.0, *)
      @objc private func _swizzledPresent(_ viewControllerToPresent: UIViewController,
                                          animated flag: Bool,
                                          completion: (() -> Void)? = nil) {
          if viewControllerToPresent.modalPresentationStyle == .pageSheet
                     || viewControllerToPresent.modalPresentationStyle == .automatic {
              viewControllerToPresent.modalPresentationStyle = .fullScreen
          }
          _swizzledPresent(viewControllerToPresent, animated: flag, completion: completion)
      }
  
}
