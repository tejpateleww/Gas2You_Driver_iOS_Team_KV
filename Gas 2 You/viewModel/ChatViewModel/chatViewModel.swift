//
//  chatViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 05/10/21.
//

import Foundation
import UIKit

class ChatUserModel{
    
//    weak var chatListVC : ChatListVC? = nil
    weak var chatViewController : ChatViewController? = nil
    
//    func webservicegetChatUserListAPI(){
//        WebServiceSubClass.getChatUserListApi{ (status, apiMessage, response, error) in
//            DispatchQueue.main.async {
//                self.chatListVC?.refreshControl.endRefreshing()
//            }
//            self.chatListVC?.isLoading = false
//            self.chatListVC?.isTblReload = true
//            if status{
//                self.chatListVC?.arrUserList = response?.data ?? []
//                self.chatListVC?.tblUserList.reloadData()
//            }else{
//                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
//            }
//        }
//    }
    
    func webserviceSendMsgAPI(reqModel: SendMsgReqModel){
        WebServiceSubClass.sendMsgAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                self.chatViewController?.arrayChatHistory.append((response?.data)!)
                self.chatViewController?.filterArrayData(isFromDidLoad: true)
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webservicegetChatHistoryAPI(BookingId:String){
       WebServiceSubClass.getChatHistoryApi(BookingId: BookingId, completion:{ (status, apiMessage, response, error) in
           self.chatViewController?.isTblReload = true
            if status{
                self.chatViewController?.bookingID = response?.bookingId ?? ""
                self.chatViewController?.senderID = response?.customerId ?? ""
                self.chatViewController?.setProfileInfo(name: response?.customerName ?? "", profile: response?.customerProfilePicture ?? "")
                self.chatViewController?.arrayChatHistory = response?.data ?? []
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.chatViewController?.filterArrayData(isFromDidLoad: true)
                }
                
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        })
    }
    
}

class NotificationModelClass{
    
    weak var notificationVC : NotificationVC? = nil
    
    func webserviceNotificationListAPI(reqModel: NotificationReqModel){
        
        self.notificationVC?.isApiProcessing = true
        WebServiceSubClass.getNotificationListApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            
            DispatchQueue.main.async {
                self.notificationVC?.refreshControl.endRefreshing()
            }
            self.notificationVC?.isLoading = false
            self.notificationVC?.isTblReload = true
            
            if status{
                self.notificationVC?.isApiProcessing = false
                
                if(response?.data?.count == 0){
                    if(self.notificationVC?.CurrentPage == 1){
                        self.notificationVC?.arrNotification = response?.data ?? []
                    }else{
                        self.notificationVC?.isStopPaging = true
                    }
                }else{
                    if(self.notificationVC?.CurrentPage == 1){
                        self.notificationVC?.arrNotification = response?.data ?? []
                    }else{
                        self.notificationVC?.arrNotification.append(contentsOf: response?.data ?? [])
                    }
                }
                self.notificationVC?.reloadData()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
}
