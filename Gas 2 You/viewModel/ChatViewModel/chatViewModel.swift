//
//  chatViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 05/10/21.
//

import Foundation
import UIKit

class ChatUserModel{
    
    weak var chatListVC : ChatListVC? = nil

    func webservicegetChatUserListAPI(){
        
        WebServiceSubClass.getChatUserListApi{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.chatListVC?.refreshControl.endRefreshing()
            }
            self.chatListVC?.isLoading = false
            self.chatListVC?.isTblReload = true
            if status{
                self.chatListVC?.arrUserList = response?.data ?? []
                self.chatListVC?.tblUserList.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
}
