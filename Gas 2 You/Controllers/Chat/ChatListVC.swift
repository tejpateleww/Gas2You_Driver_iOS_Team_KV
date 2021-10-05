//
//  ChatListVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit
import SDWebImage
import UIView_Shimmer

class ChatListVC: BaseVC {
    
    @IBOutlet weak var tblUserList: UITableView!
    
    var arrUserList = [ChatUserListDatum]()
    var chatUserModel = ChatUserModel()
    var isTblReload = false
    var isLoading = true {
        didSet {
            self.tblUserList.isUserInteractionEnabled = !isLoading
            self.tblUserList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.registerNib()
        self.callUserListAPI()
    }
    
    func prepareView(){
        self.isLoading = true
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Chat", leftImage: "Back", rightImages: [], isTranslucent: true)
    }
    
    func registerNib(){
        let nib1 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblUserList.register(nib1, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrUserList.count > 0 {
            return self.arrUserList.count
        } else {
            return (!isTblReload) ? 5 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblUserList.dequeueReusableCell(withIdentifier: "cell") as! ChatListCell
        
        if(!isTblReload){
            cell.lblUserName.text = "AAAAA AAAAA"
            cell.lblMsg.text = "Hello 123 Hello 123 Hello 123"
            cell.lblTime.text = "06:58 AM"
            return cell
        }else{
            if(self.arrUserList.count > 0){
                let dict = self.arrUserList[indexPath.row]
                cell.lblUserName.text = dict.fullName ?? ""
                cell.lblMsg.text = dict.message ?? ""
                cell.lblTime.text = dict.createdAt ?? ""
                
                let strUrl = dict.image ?? ""
                let strURl = URL(string: strUrl)
                cell.userImg.sd_imageIndicator = SDWebImageActivityIndicator.white
                cell.userImg.sd_setImage(with: strURl, placeholderImage: UIImage(named: "AppIcon"), options: .refreshCached, completed: nil)
                
                return cell
            }else{
                let NoDatacell = self.tblUserList.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                return NoDatacell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ChatViewController = ChatViewController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrUserList.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
}

//MARK:- Api Calls
extension ChatListVC{
    
    func callUserListAPI(){
        self.chatUserModel.chatListVC = self
        self.chatUserModel.webservicegetChatUserListAPI()
    }
}
