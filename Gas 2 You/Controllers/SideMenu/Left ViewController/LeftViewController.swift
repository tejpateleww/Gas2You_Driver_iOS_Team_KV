//
//  LeftViewController.swift
//  CoreSound
//
//  Created by EWW083 on 05/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
import MediaPlayer
import SDWebImage
//import InteractiveSideMenu

class LeftViewController: MenuViewController {
   

    @IBOutlet weak var MenuTblView : UITableView!
    @IBOutlet weak var ConstantMenuTblViewHeight : NSLayoutConstraint!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var imgUser: RoundedImageView!
    @IBOutlet weak var lblUserName: themeLabel!
    @IBOutlet weak var lblUserActiveStatus: themeLabel!
    @IBOutlet weak var lblVersion: themeLabel!
    
    //MARK:- Properties
    ///0 for menu name 1 for icon name
    private let titlesArray : [(String,String)] = [("Home","ic_Home"),
                                                   ("My Orders","ic_MyOrders"),
                                                   ("My Profile","ic_MyProfile"),
                                                   ("Settings","ic_Settings"),
                                                   ("Notifications","ic_Notifications")]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MenuTblView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        self.prepareView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    //MARK: -Other Methods
    func prepareView(){
        
        let obj = Singleton.sharedInstance.UserProfilData
        let strUrl = "\(APIEnvironment.Profilebu.rawValue)" + "\(obj?.profileImage ?? "")"
        let strURl = URL(string: strUrl)
        
        self.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.imgUser.sd_setImage(with: strURl, placeholderImage: #imageLiteral(resourceName: "imgDummyProfile"), options: .refreshCached, completed: nil)
        
        self.lblUserName.text = "\(obj?.fullName ?? "")"
        self.lblUserActiveStatus.text = (obj?.status ?? "" == "1") ? "Active" : "Deactive"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.lblVersion.text = "V \(appVersion ?? "0.0")"
    }
    
    @IBAction func btnProfileTap(_ sender: Any) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        let vc : MyProfileVC = MyProfileVC.instantiate(fromAppStoryboard: .Main)
        (menuContainerViewController.contentViewControllers[0] as? NavigationController)?.pushViewController(vc, animated: false)
        
        menuContainerViewController.hideSideMenu()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnLogoutTap(_ sender: UIButton) {
        
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        LeftViewController.showAlertWithTitleFromVC(vc: self, title: "Logout", message: "Are you sure want to Logout?", buttons: ["Cancel", "Logout"]) { index in
            menuContainerViewController.hideSideMenu()
            if index == 1 {
                AppDel.dologout()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: -  Observer method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        MenuTblView.layer.removeAllAnimations()
        ConstantMenuTblViewHeight.constant = MenuTblView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
  
}
extension LeftViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuTblView.dequeueReusableCell(withIdentifier: "LeftViewMenuItemCell", for: indexPath) as! LeftViewMenuItemCell
        cell.LblMenuItem.text = titlesArray[indexPath.row].0
        cell.ImageViewMenuIcon.image = UIImage(named: titlesArray[indexPath.row].1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        
        if titlesArray[indexPath.row].0 == "Home" {
            menuContainerViewController.hideSideMenu()
        }else if titlesArray[indexPath.row].0 == "My Orders"{
            let vc : CompletedJobsVC = CompletedJobsVC.instantiate(fromAppStoryboard: .Main)
            (menuContainerViewController.contentViewControllers[0] as? NavigationController)?.pushViewController(vc, animated: false)
            
            menuContainerViewController.hideSideMenu()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if titlesArray[indexPath.row].0 == "My Profile"{
            let vc : MyProfileVC = MyProfileVC.instantiate(fromAppStoryboard: .Main)
            (menuContainerViewController.contentViewControllers[0] as? NavigationController)?.pushViewController(vc, animated: false)
            
            menuContainerViewController.hideSideMenu()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if titlesArray[indexPath.row].0 == "Membership"{
            
        }else if titlesArray[indexPath.row].0 == "Settings"{
            let vc : SettingsVC = SettingsVC.instantiate(fromAppStoryboard: .Main)
            (menuContainerViewController.contentViewControllers[0] as? NavigationController)?.pushViewController(vc, animated: false)
            
            menuContainerViewController.hideSideMenu()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc : NotificationVC = NotificationVC.instantiate(fromAppStoryboard: .Main)
            (menuContainerViewController.contentViewControllers[0] as? NavigationController)?.pushViewController(vc, animated: false)
            
            menuContainerViewController.hideSideMenu()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension LeftViewController : MPMediaPickerControllerDelegate {
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // Get the system music player.
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        musicPlayer.setQueue(with: mediaItemCollection)
        mediaPicker.dismiss(animated: true)
        // Begin playback.
        musicPlayer.play()
    }

    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true)
    }
    
}

class LeftViewMenuItemCell : UITableViewCell {
    @IBOutlet weak var LblMenuItem : themeLabel!
    @IBOutlet weak var ImageViewMenuIcon : UIImageView!
}
