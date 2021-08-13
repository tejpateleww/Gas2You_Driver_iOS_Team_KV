//
//  NotificationVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 10/08/21.
//

import UIKit

struct notification{
    var img : UIImage?
    var msg : String?
}

class NotificationVC: BaseVC {
    
    @IBOutlet weak var tblNotification: UITableView!
    
    var arrNotification = [notification]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Notifications", leftImage: "Back", rightImages: [], isTranslucent: true)
        tblNotification.delegate = self
        tblNotification.dataSource = self
        let nib = UINib(nibName: NotificationCell.className, bundle: nil)
        tblNotification.register(nib, forCellReuseIdentifier: NotificationCell.className)
        
        arrNotification.append(notification(img: #imageLiteral(resourceName: "imgDarkBlueRight"), msg: "Your Ordervjhvchjdsvdcjhvcjhvjhdscvdsjhcdvcjhdscvdsjhcvcjhdsvcdsjhcvdsjchsdvcjhdcvdsjhcvdchjdsvcjdhscvdsjhcdsvcdsjhcdsvchjds #1234 has been placed"))
        arrNotification.append(notification(img: #imageLiteral(resourceName: "imgGreenRight"), msg: "Your Order #1234 has been completed"))
        arrNotification.append(notification(img: #imageLiteral(resourceName: "imgCancel"), msg: "Your booking #1205 has been cancelled"))
        arrNotification.append(notification(img: #imageLiteral(resourceName: "imgDarkBlueRight"), msg: "Your Order #1234 has been placed"))
        arrNotification.append(notification(img: #imageLiteral(resourceName: "imgDarkBlueRight"), msg: "Your Order #1234 has been placed"))

        // Do any additional setup after loading the view.
    }
    
}
//MARK:- UITableView Methods
extension NotificationVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNotification.dequeueReusableCell(withIdentifier: NotificationCell.className) as! NotificationCell
        cell.imgNotification.image = arrNotification[indexPath.row].img
        cell.lblNotification.text = arrNotification[indexPath.row].msg
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
