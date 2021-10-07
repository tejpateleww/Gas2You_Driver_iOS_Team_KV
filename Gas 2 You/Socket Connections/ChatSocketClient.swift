//
//  ChatSocketClient.swift
//
//  Created by Apple on 06/04/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import SwiftyJSON

extension ChatListVC{
    
    //MARK:- Socket On All
    func ChatSocketOnMethods() {
        
        SocketIOManager.shared.socket.on(clientEvent: .disconnect) { (data, ack) in
            print ("socket is disconnected please reconnect")
            SocketIOManager.shared.isSocketOn = false
        }
        
        SocketIOManager.shared.socket.on(clientEvent: .reconnect) { (data, ack) in
            print ("socket is reconnected")
            SocketIOManager.shared.isSocketOn = true
        }
        
        print("===========\(SocketIOManager.shared.socket.status)========================",SocketIOManager.shared.socket.status.active)
        SocketIOManager.shared.socket.on(clientEvent: .connect) {data, ack in
            print ("socket connected")
            SocketIOManager.shared.isSocketOn = true
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        if(SocketIOManager.shared.socket.status == .connected){
            self.ChatSocketOffMethods()
            self.emitSocket_UserConnect()
            self.allChatSocketOnMethods()
        }
        
        SocketIOManager.shared.establishConnection()
        print("==============\(SocketIOManager.shared.socket.status)=====================",SocketIOManager.shared.socket.status.active)
    }
    
    //MARK:- Active Socket Methods
    func allChatSocketOnMethods() {
        onSocketConnectUser()
    }
    
    //MARK:- Deactive Socket Methods
    func ChatSocketOffMethods() {
        SocketIOManager.shared.socket.off(SocketKeys.ConnectUser.rawValue)
    }
    
    //MARK:- On Methods
    func onSocketConnectUser(){
        SocketIOManager.shared.socketCall(for: SocketKeys.ConnectUser.rawValue) { (json) in
            print(#function, "\n ", json)
        }
    }
    

    //MARK:- Emit Methods
    func emitSocket_UserConnect(){
        print(#function)
        let param: [String: Any] = ["driver_id" : Singleton.sharedInstance.UserId]
        SocketIOManager.shared.socketEmit(for: SocketKeys.ConnectUser.rawValue, with: param)
    }
    
}
