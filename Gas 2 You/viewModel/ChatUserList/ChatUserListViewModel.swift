//
//  ChatUserListViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 30/11/21.
//

import Foundation

class ChatUserListViewModel{
    
    weak var chatListVC : ChatListVC? = nil

    func webserviceGetChatUserListAPI(){
        WebServiceSubClass.getChatUsersApi{ (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.chatListVC?.refreshControl.endRefreshing()
            }
            self.chatListVC?.isLoading = false
            self.chatListVC?.isTblReload = true
            if status{
                self.chatListVC?.arrUserList = (response?.data != nil) ? response?.data ?? [] : []
                self.chatListVC?.tblUserList.reloadData()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
}
