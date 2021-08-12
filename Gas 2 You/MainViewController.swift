//
//  MainViewController.swift
//  CoreSound
//
//  Created by EWW083 on 05/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
//import LGSideMenuController
//import InteractiveSideMenu
class MainViewController: MenuContainerViewController {
      override var prefersStatusBarHidden: Bool {
         return false
     }
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used

     override func viewDidLoad() {
         super.viewDidLoad()

//         let screenSize: CGRect = UIScreen.main.bounds
//         self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)

         // Instantiate menu view controller by identifier
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isHidden = true
        self.menuViewController = mainStoryboard.instantiateViewController(withIdentifier: "LeftViewController") as? MenuViewController//LeftViewController.storyboardViewController()") as?

         // Gather content items controllers
         self.contentViewControllers = contentControllers()

         // Select initial content controller. It's needed even if the first view controller should be selected.
         self.selectContentViewController(contentViewControllers.first!)
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute:  {
//            AppDel.navigateToLogin()
//        })

//         self.currentItemOptions.cornerRadius = 10.0
     }

//     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//         super.viewWillTransition(to: size, with: coordinator)
//
//         // Options to customize menu transition animation.
//         var options = TransitionOptions()
//
//         // Animation duration
//         options.duration = size.width < size.height ? 0.4 : 0.6
//
//         // Part of item content remaining visible on right when menu is shown
//         options.visibleContentWidth = size.width / 6
//         self.transitionOptions = options
//     }

     private func contentControllers() -> [UIViewController] {
        let homeController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationHome") as! NavigationController
       
         return [homeController]
     }
    
}
