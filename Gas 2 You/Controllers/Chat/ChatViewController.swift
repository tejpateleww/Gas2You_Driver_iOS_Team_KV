//
//  chatVC.swift
//  PickARide User
//
//  Created by Apple on 19/01/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import UIKit
import UIView_Shimmer
import IQKeyboardManagerSwift

class ChatViewController: BaseVC {

    //MARK:- IBOutlets
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var txtviewComment: ratingTextview!
    @IBOutlet var vwNavBar: UIView!
    @IBOutlet weak var lblChatText: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    //MARK:- Properties
    var isLoading = true {
        didSet {
            self.tblChat.isUserInteractionEnabled = !isLoading
            self.tblChat.reloadData()
        }
    }
    var userData : ChatUserListDatum?
    var isTblReload = false
    var arrayChatHistory = [chatHistoryDatum]()
    var filterListArr : [String: [chatHistoryDatum]] = [String(): [chatHistoryDatum]()]
    var filterKeysArr : [Date] = [Date]()
    var oldChatSectionTitle = Date()
    var oldChatId = String()
    
    //MARK:- LifeCycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.ChatSocketOnMethods()
        self.setupKeyboard(false)
        self.hideKeyboard()
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //self.ChatSocketOffMethods()
        self.setupKeyboard(true)
        self.deregisterFromKeyboardNotifications()
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isTblReload = true
            self.tblChat.reloadData()
        }
        
        self.prepareView()
        self.registerNib()
        self.setProfileInfo()
    }
    
    //MARK:- Custom methods
    func prepareView(){
        self.NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: self.userData?.fullName ?? "", controller: self)
        self.navBarRightImage(imgURL: self.userData?.image ?? "")
        self.txtviewComment.delegate = self
        self.txtviewComment.font = CustomFont.PoppinsRegular.returnFont(16)
        self.txtviewComment.textColor = txtviewComment.text == "" ? .black : .gray
    }
    
    func registerNib(){
        let nib = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblChat.register(nib, forCellReuseIdentifier: NoDataTableViewCell.className)
        let nib1 = UINib(nibName: ChatShimmer.className, bundle: nil)
        self.tblChat.register(nib1, forCellReuseIdentifier: ChatShimmer.className)
    }
    
    func setProfileInfo(){
        
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.arrayChatHistory.count > 0 {
                let list = self.filterListArr[self.filterKeysArr.last?.Date_In_DD_MM_YYYY_FORMAT ?? String ()]
                
                let rowIndex = list?.count == 0 ? 0 : ((list?.count ?? 0) - 1)
                let indexPath = IndexPath(row: rowIndex, section: self.filterKeysArr.count - 1)
                self.tblChat.reloadData()
                self.tblChat.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }

    func scrollAt(){
        if self.arrayChatHistory.count > 0 {
            let list = self.filterListArr[oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT ?? ""]
            let row = list?.firstIndex(where: {$0.id == oldChatId}) ?? 0
            let section = self.filterKeysArr.firstIndex(where: {$0.Date_In_DD_MM_YYYY_FORMAT == oldChatSectionTitle.Date_In_DD_MM_YYYY_FORMAT}) ?? 0
            let indexPath = IndexPath(row: row, section: section)
            self.tblChat.reloadData()
            self.tblChat.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func scrollToFirstRow() {
        self.tblChat.layoutIfNeeded()
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tblChat.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
    }
    
    func filterArrayData(isFromDidLoad: Bool){
        self.filterListArr.removeAll()
        self.filterKeysArr.removeAll()
        self.arrayChatHistory.sort(by: {$0.createdAt!.compare($1.createdAt!) == .orderedAscending})
        for each in self.arrayChatHistory{
            let dateField = each.createdAt?.serverDateStringToDateType1?.Date_In_DD_MM_YYYY_FORMAT ?? String ()
            if filterListArr.keys.contains(dateField){
                filterListArr[dateField]?.append(each)
            }else{
                filterListArr[dateField] = [each]
                self.filterKeysArr.append(each.createdAt?.serverDateStringToDateType1 ?? Date())
            }
        }
        self.filterKeysArr.sort(by: <)
        isFromDidLoad ? self.scrollToBottom() : self.scrollAt()
    }
}


//MARK:- Textview Delegate
extension ChatViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtviewComment.textColor == .lightGray {
            txtviewComment.text = nil
            txtviewComment.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.lblChatText.text = self.txtviewComment.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtviewComment.text.isEmpty {
            txtviewComment.text = "Start Typing..."
            txtviewComment.textColor = .lightGray
        }
    }
}


//MARK: -tableviewDelegate
extension ChatViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.arrayChatHistory.count > 0 {
            return self.filterKeysArr.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayChatHistory.count > 0 {
            let strDate = self.filterKeysArr[section].Date_In_DD_MM_YYYY_FORMAT ?? ""
            return self.filterListArr[strDate]?.count ?? 0
        } else {
            return (!self.isTblReload) ? 5 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:30.0))
        if(self.arrayChatHistory.count > 0){
            let cell = tblChat.dequeueReusableCell(withIdentifier: chatHeaderCell.className) as! chatHeaderCell
            let obj = self.filterKeysArr[section]
            cell.vwMain.layer.cornerRadius = 15
            cell.lblDateTime.text = obj.timeAgoSinceDate(isForNotification: true)
            cell.lblDateTime.textAlignment = .center
            headerView.addSubview(cell)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(!self.isTblReload){
            let cell = tblChat.dequeueReusableCell(withIdentifier: ChatShimmer.className, for: indexPath) as! ChatShimmer
            return cell
        }else{
            if(self.arrayChatHistory.count > 0){
                let strDateTitle = self.filterKeysArr[indexPath.section].Date_In_DD_MM_YYYY_FORMAT ?? ""
                let obj = self.filterListArr[strDateTitle]?[indexPath.row]
                
                let isDriver = obj?.senderType ?? "" == "driver"
                if(isDriver){
                    let cell = tblChat.dequeueReusableCell(withIdentifier: chatSenderCell.className, for: indexPath) as! chatSenderCell
                    cell.selectionStyle = .none
                    cell.lblSenderMessage.text = obj?.message ?? ""
                    return cell
                }else{
                    let cell = tblChat.dequeueReusableCell(withIdentifier: chatReciverCell.className, for: indexPath) as! chatReciverCell
                    cell.selectionStyle = .none
                    cell.lblReciverMessage.text = obj?.message ?? ""
                    return cell
                }
            }else{
                let NoDatacell = self.tblChat.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                return NoDatacell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!self.isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrayChatHistory.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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

//MARK: KEYBOARD SETUP FOR CHATBOX
extension ChatViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboards))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboards()
    {
        view.endEditing(true)
    }
    
    func setupKeyboard(_ enable: Bool) {
        IQKeyboardManager.shared.enable = enable
        IQKeyboardManager.shared.enableAutoToolbar = enable
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = !enable
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        keyboardHeightLayoutConstraint?.constant = 0
        self.animateConstraintWithDuration()
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        
        if #available(iOS 11.0, *) {
            
            DispatchQueue.main.async {
                if self.arrayChatHistory.count != 0 {
                    self.scrollToBottom()
                }
            }
            keyboardHeightLayoutConstraint?.constant = keyboardSize!.height - view.safeAreaInsets.bottom
            
        } else {
            
            DispatchQueue.main.async {
                if self.arrayChatHistory.count != 0 {
                    self.scrollToBottom()
                }
            }
            keyboardHeightLayoutConstraint?.constant = keyboardSize!.height - 10
            
        }
        self.animateConstraintWithDuration()
    }
    
    func deregisterFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func animateConstraintWithDuration(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.loadViewIfNeeded() ?? ()
        })
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
