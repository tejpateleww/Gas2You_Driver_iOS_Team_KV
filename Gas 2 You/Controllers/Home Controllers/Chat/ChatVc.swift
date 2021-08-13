//
//  ChatVc.swift
//  Gas 2 You Driver
//
//  Created by Apple on 13/08/21.
//

import UIKit

class ChatConversation {
    var MessageDate : String?
    var MessageData : [MessageAllData]?
    init(date:String,Data:[MessageAllData]) {
        self.MessageDate = date
        self.MessageData = Data
    }
}

class MessageAllData {
    var isFromSender : Bool?
    var chatMessage : String?
    var isLastMessage : Bool?
    init(fromSender:Bool,message:String,lastMessage:Bool) {
        self.isLastMessage = lastMessage
        self.isFromSender = fromSender
        self.chatMessage = message
    }
}

class ChatVc: UIViewController {

    @IBOutlet weak var tblChat: UITableView!
    
    var MessageArray = [ChatConversation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableFormatting()
        self.setUpMessage()
    }
}

//MARK:- Methods
extension ChatVc{
    func setUpTableFormatting(){
        self.tblChat.register(UINib(nibName: "ChatMessageCell", bundle: nil), forCellReuseIdentifier: "SenderCell")
        self.tblChat.register(UINib(nibName: "ChatMessageCell", bundle: nil), forCellReuseIdentifier: "ReceiverCell")
    }
    
    func setUpMessage() {
        MessageArray.append(ChatConversation(date: "Today at 5:03 PM", Data: [MessageAllData(fromSender: true, message: "Hello, are you nearby?", lastMessage: false), MessageAllData(fromSender: false, message: "I'll be there in a few mins", lastMessage: true), MessageAllData(fromSender: true, message: "OK, I'm in front of the bus stop", lastMessage: true) ]))
        MessageArray.append(ChatConversation(date: "5:33 PM", Data: [MessageAllData(fromSender: false, message: "Sorry , I'm stuck in traffic. Please give me a moment.", lastMessage: true) ]))
        
        self.tblChat.reloadData()
    }
}

//MARK:- TabelView Delegate
extension ChatVc: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return MessageArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageArray[section].MessageData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.tblChat.dequeueReusableCell(withIdentifier: "ChatTimeHeaderCell") as? ChatHeaderCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isSender = indexPath.row % 2 == 0
        let strCellId = isSender ? "SenderCell" : "ReceiverCell"
        let cell = self.tblChat.dequeueReusableCell(withIdentifier: strCellId, for: indexPath) as? ChatMessageCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
