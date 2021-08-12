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
        
        //NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "Chat", controller: self)
    }
    

}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatListTV.dequeueReusableCell(withIdentifier: "cell") as! ChatListCell
        
        return cell
    }
}
