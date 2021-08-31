//
//  Stotyboards.swift
//  MyVagon
//
//  Created by iMac on 15/07/21.
//
import UIKit
import Foundation
enum AppStoryboard : String {
    // Please use same storyboard name as the name of cases in enum, Case-sensitive.
    // You can skip raw values as for string type enums, case name is the implicit raw value.
    
    case Main, Login, Chat
    
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
         
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

/* Usage :
  //check UIViewController+Extension for instantiate func.
 let greenScene = GreenVC.instantiate(fromAppStoryboard: .Main)

 let greenScene = AppStoryboard.Main.viewController(viewControllerClass: GreenVC.self)

 let greenScene = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: GreenVC.storyboardID)
*/

