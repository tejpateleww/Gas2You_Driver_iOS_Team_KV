//
//  ChatListVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class ChatListVC: BaseVC {

    @IBOutlet weak var chatListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Chat", leftImage: "Back", rightImages: [], isTranslucent: true)
        DispatchQueue.main.async {
            self.chatListTV.reloadData()
        }
       
        //NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "Chat", controller: self)
    }
    

}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatListTV.dequeueReusableCell(withIdentifier: "cell") as! ChatListCell
        if indexPath.row == 0 {
            cell.LblMessage.textColor = .black
        } else {
            cell.LblMessage.textColor = UIColor(hexString: "#ACB1C0")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ChatViewController = ChatViewController.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
