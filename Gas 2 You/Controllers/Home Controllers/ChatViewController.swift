//
//  chatVC.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit

class ChatViewController: BaseVC {



    //MARK: -Properties
    var MessageArray = [ChatConversation]()
    //MARK: -IBOutlets
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var txtviewComment: ratingTextview!
    @IBOutlet var vwNavBar: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    //MARK: -View Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        txtviewComment.delegate = self
        txtviewComment.textColor = txtviewComment.text == "" ? .black : .gray
        setLocalization()
        setValue()
        MessageArray.append(ChatConversation(date: "Today at 5:03 PM", Data: [MessageAllData(fromSender: true, message: "Hello, are you nearby?", lastMessage: false),
                                                                              MessageAllData(fromSender: false, message: "I'll be there in a few mins", lastMessage: true),
                                                                              MessageAllData(fromSender: true, message: "OK, I'm in front of the bus stop", lastMessage: true)
                                                                        ]))
        MessageArray.append(ChatConversation(date: "5:33 PM", Data: [MessageAllData(fromSender: false, message: "Sorry , I'm stuck in traffic. Please give me a moment.", lastMessage: true)
                                                                        ]))
        
        setNavigationBarInViewController(controller: self, naviColor: .white, naviTitle: "Elen Glibert", leftImage: "", rightImages: [], isTranslucent: true)
        navBarRightImage()
        
        txtviewComment.font = CustomFont.PoppinsRegular.returnFont(16)
//        self.setNavigationBarInViewController(controller: self, naviColor: colors.white.value, naviTitle: "", leftImage: #imageLiteral(resourceName: "IC_backButton"), rightImages: [], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
        
        tblChat.reloadData()


        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardNotification(notification:)),name: UIResponder.keyboardWillChangeFrameNotification,object: nil)


        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        tblChat.addGestureRecognizer(dismissKeyboardGesture)


    }

    deinit {
        NotificationCenter.default.removeObserver(self)
      }


    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    func navBarRightImage() {
        
        let viewFN = UIView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        //        viewFN.backgroundColor = .red
        let userImage = UIButton(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        userImage.setImage( #imageLiteral(resourceName: "dummy_user"), for: .normal)
//        userImage.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        userImage.isUserInteractionEnabled = false
        viewFN.addSubview(userImage)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        navigationItem.rightBarButtonItem = rightBarButton
        
        
        
//        let button = UIButton(type: UIButton.ButtonType.custom)
//        button.setImage(#imageLiteral(resourceName: "IC_dummyImg2"), for: .normal)
//        button.contentMode = .scaleAspectFill
////        button.addTarget(self, action:#selector(callMethod), for: .touchDragInside)
//        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.rightBarButtonItems = [barButton]
        
    }


    //MARK: -Bring up and down the keyboard
    @objc func keyboardNotification(notification: NSNotification) {
      guard let userInfo = notification.userInfo else { return }

      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
      let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

      if endFrameY >= UIScreen.main.bounds.size.height {
        self.keyboardHeightLayoutConstraint?.constant = 0.0
      } else {
        self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
      }

      UIView.animate(
        withDuration: duration,
        delay: TimeInterval(0),
        options: animationCurve,
        animations: { self.view.layoutIfNeeded() },
        completion: nil)
    }
    //MARK: -other methods
    func setLocalization() {

    }
    func setValue() {
    }



    //MARK: -IBActions


    //MARK: -API Calls



}


//MARK:- Textview Delegate
extension ChatViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        txtviewComment.text = txtviewComment.text ==  "Type a message..." ? "" : txtviewComment.text
        txtviewComment.textColor = .black
        return true
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
//        self.txtviewComment.text = txtviewComment.text
        
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        txtviewComment.text = txtviewComment.text == "" ? "Type a message..." : txtviewComment.text
        txtviewComment.textColor = txtviewComment.text == "" ? .black : .gray
    }
}
//MARK: -tableviewDelegate
extension ChatViewController : UITableViewDelegate, UITableViewDataSource
{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageArray[section].MessageData!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender == true {
            let SenderCell = tblChat.dequeueReusableCell(withIdentifier: chatSenderCell.className, for: indexPath) as! chatSenderCell
            SenderCell.lblSenderMessage.text = MessageArray[indexPath.section].MessageData![indexPath.row].chatMessage
            SenderCell.lblBottomView.isHidden = false

//            if indexPath.row != 0 {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate!.count - 1 {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row - 1].isFromSender!)   {
//                        SenderCell.lblBottomView.isHidden = false
//                    } else {
//                        SenderCell.lblBottomView.isHidden = true
//                    }
//                } else {
//                    SenderCell.lblBottomView.isHidden = false
//                }
//
//
//            } else {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate!.count - 1 {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row + 1].isFromSender!)   {
//                        SenderCell.lblBottomView.isHidden = true
//                    } else {
//                        SenderCell.lblBottomView.isHidden = false
//                    }
//                } else {
//                    SenderCell.lblBottomView.isHidden = false
//                }
//            }



//            if MessageArray[indexPath.section].MessageData![indexPath.row].isLastMessage != true {
//
//            }
            cell = SenderCell

        } else {
            let ReciverCell = tblChat.dequeueReusableCell(withIdentifier: chatReciverCell.className, for: indexPath) as! chatReciverCell
            ReciverCell.lblReciverMessage.text = MessageArray[indexPath.section].MessageData![indexPath.row].chatMessage
            ReciverCell.lblBottomView.isHidden = false
//            if indexPath.row != 0 {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate?.count {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row - 1].isFromSender!)   {
//                        ReciverCell.lblBottomView.isHidden = false
//                    } else {
//                        ReciverCell.lblBottomView.isHidden = true
//                    }
//                } else {
//                    ReciverCell.lblBottomView.isHidden = false
//                }
//
//
//            } else {
//                if indexPath.row != MessageArray[indexPath.section].MessageDate?.count {
//                    if (MessageArray[indexPath.section].MessageData![indexPath.row].isFromSender!) && (MessageArray[indexPath.section].MessageData![indexPath.row + 1].isFromSender!)   {
//                        ReciverCell.lblBottomView.isHidden = true
//                    } else {
//                        ReciverCell.lblBottomView.isHidden = false
//                    }
//                } else {
//                    ReciverCell.lblBottomView.isHidden = false
//                }
//            }

            cell = ReciverCell
        }

        return cell

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MessageArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tblChat.dequeueReusableCell(withIdentifier: chatHeaderCell.className) as! chatHeaderCell
        cell.vwMain.layer.cornerRadius = cell.vwMain.frame.height / 2
        cell.lblDateTime.text = MessageArray[section].MessageDate
        return cell
    }
}
class chatSenderCell : UITableViewCell {

    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblSenderView: chatScreenView!
    @IBOutlet weak var lblSenderMessage: chatScreenLabel!
}
class chatReciverCell : UITableViewCell {
    @IBOutlet weak var lblBottomView: UIView!
    @IBOutlet weak var lblReciverView: chatScreenView!
    @IBOutlet weak var lblReciverMessage: chatScreenLabel!
}
class chatHeaderCell : UITableViewCell {

    @IBOutlet weak var lblDateTime: chatScreenLabel!
    @IBOutlet weak var vwMain: UIView!
}

