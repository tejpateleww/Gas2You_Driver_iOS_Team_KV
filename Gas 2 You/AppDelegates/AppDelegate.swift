//
//  AppDelegate.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import GoogleMaps


let AppDel = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate {
            return UIApplication.shared.delegate as! AppDelegate
        }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyAsK4EKl6GkGqELS8YySwoIWVjNjAwR7dg")
        
        navigateToLogin()
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Gas_2_You")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyboard.instantiateViewController(identifier: "LogInVC") as! LogInVC
        window?.rootViewController = UINavigationController(rootViewController: logInVC)
    }
   
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyboard.instantiateViewController(identifier: MainViewController.className) as! MainViewController
        logInVC.navigationController?.navigationBar.isHidden = false
       window?.rootViewController = UINavigationController(rootViewController: logInVC)
    }
}


