//
//  HomeVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit

class HomeVC: BaseVC {

    //MARK:- OUTLETS
    @IBOutlet weak var btnRequest: ThemeButton!
    @IBOutlet weak var btnInProgress: themeButton!
    @IBOutlet weak var vwInprogress: UIView!
    @IBOutlet weak var vwRequest: UIView!
    @IBOutlet weak var tblHome: UITableView!
    
    //MARK:- GLOBAL PROPERTIES
    var isInProcess : Bool = false
    
    //MARK:- VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Home", leftImage: "Menu", rightImages: [], isTranslucent: true)
        
        self.navigationController?.navigationBar.isHidden = false
        tblHome.delegate = self
        tblHome.dataSource = self
        rightNavBarButton()
        let nib = UINib(nibName: JobsCell.className, bundle: nil)
        tblHome.register(nib, forCellReuseIdentifier: JobsCell.className)
    }
    func rightNavBarButton(){
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "ic_chat"), for: .normal)
        button.addTarget(self, action:#selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
    }
    @objc func callMethod(){
        let vc : ChatListVC = ChatListVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- ACTIONS

    
    @IBAction func btnRequestTap(_ sender: UIButton) {
        btnRequest.titleLabel?.font = CustomFont.PoppinsBold.returnFont(14)
        vwRequest.backgroundColor = UIColor.init(hexString: "#1F79CD")
        btnInProgress.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(14)
        vwInprogress.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.3)
        isInProcess = false
        tblHome.reloadData()
    }
    @IBAction func btnInprogressTap(_ sender: UIButton) {
        btnRequest.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(14)
        vwRequest.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.3)
        btnInProgress.titleLabel?.font = CustomFont.PoppinsBold.returnFont(14)
        vwInprogress.backgroundColor = UIColor.init(hexString: "#1F79CD")
        isInProcess = true
        tblHome.reloadData()
    }
    
}

//MARK:- UITableview Methods
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblHome.dequeueReusableCell(withIdentifier: JobsCell.className) as! JobsCell
        cell.btnReject.isHidden = isInProcess ? true : false
        cell.btnAccept.setTitle(isInProcess ? "Start Job" : "ACCEPT", for: .normal)
        cell.btnAcceptTapClosure = {
            HomeVC.showAlertWithTitleFromVC(vc: self, title: "Gas2YouDriver", message: "Are you sure you want to start job ?", buttons: ["Cancel", "OK"]) { index in
                if index == 1{
                    let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
                    vc.isFromStartJob = true
                    vc.isfrom = .InProcess
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        cell.vwButtons.isHidden = isInProcess ? false : true
        cell.stackButtomHeight.constant = cell.vwButtons.isHidden ? 17 : 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if isInProcess {
            let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
            vc.isfrom = isInProcess ? isFromHome.InProcess : isFromHome.Request
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
