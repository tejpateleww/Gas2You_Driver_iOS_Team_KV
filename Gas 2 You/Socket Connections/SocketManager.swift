//
//  SocketManager.swift
//  CabRideDriver
//
//  Created by EWW-iMac Old on 29/04/19.
//  Copyright © 2019 baps. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON
import SocketIO

typealias CompletionBlock = ((JSON) -> ())?

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()

    let manager = SocketManager(socketURL: URL(string: SocketKeys.KHostUrl.rawValue)!, config: [.log(false), .compress,.version(.two)])
   // let manager = SocketManager(socketURL: URL(string: SocketKeys.KHostUrl.rawValue)!, config: [.log(true), .compress])
      lazy var socket = manager.defaultSocket
    
      var isSocketOn = false
    
    override private init() {
        super.init()
        
      
        
   }
   
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
        
    }
    
    func socketCall(for key: String, completion: CompletionBlock = nil)
    {
        if SocketIOManager.shared.socket.status == .connected {
            SocketIOManager.shared.socket.on(key, callback: { (data, ack) in
                let result = self.dataSerializationToJson(data: data)
                guard result.status else { return }
                if completion != nil { completion!(result.json) }
            })
        }
        else {
            print("\n\n Socket Disconnected \n\n")
        }
        
    }
   
    func socketEmit(for key: String, with parameter: [String:Any]){
        
        socket.emit(key, with: [parameter], completion: nil)
        print ("Parameter Emitted for key - \(key) :: \(parameter)")
    }
    
    
    
    
    func dataSerializationToJson(data: [Any],_ description : String = "") -> (status: Bool, json: JSON){
        let json = JSON(data)
//        print (description, ": \(json)")

        return (true, json)
    }
   
}
