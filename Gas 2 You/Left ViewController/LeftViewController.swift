//
//  LeftViewController.swift
//  CoreSound
//
//  Created by EWW083 on 05/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit
import MediaPlayer
//import InteractiveSideMenu

class LeftViewController: MenuViewController {
   
    
    
    
    @IBOutlet weak var MenuTblView : UITableView!
    @IBOutlet weak var ConstantMenuTblViewHeight : NSLayoutConstraint!
    
    //MARK:- Properties
    ///0 for menu name 1 for icon name
    private let titlesArray : [(String,String)] = [("Home","ic_Home"),
                                                   ("My Orders","ic_MyOrders"),
                                                   ("My Profile","ic_MyProfile"),
                                                   ("Membership","ic_Membership"),
                                                   ("Settings","ic_Settings"),
                                                   ("Notifications","ic_Notifications")]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MenuTblView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
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
        if titlesArray[indexPath.row].0 == "Home" {
            
        }else if titlesArray[indexPath.row].0 == "My Orders"{
            
        }else if titlesArray[indexPath.row].0 == "My Profile"{
            
        }else if titlesArray[indexPath.row].0 == "Membership"{
            
        }else if titlesArray[indexPath.row].0 == "Settings"{
            
        }else{
            let vc : NotificationVC = NotificationVC.instantiate(fromAppStoryboard: .Main)
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
