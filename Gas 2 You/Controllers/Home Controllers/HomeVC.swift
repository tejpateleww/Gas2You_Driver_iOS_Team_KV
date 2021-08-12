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
        
        let nib = UINib(nibName: JobsCell.className, bundle: nil)
        tblHome.register(nib, forCellReuseIdentifier: JobsCell.className)
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isInProcess {
                    let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
                    
            
        }
    }
    
}
