//
//  MyEarningsVC.swift
//  Gas 2 You
//
//  Created by Harsh on 09/08/21.
//

import UIKit

class MyEarningsVC: BaseVC {
    
    //MARK:- IBOutlets:-
    
    @IBOutlet weak var lblTotalEarningsPrice: themeLabel!
    @IBOutlet weak var lblTotalEarnings: themeLabel!
    @IBOutlet weak var lblHistory: themeLabel!
    @IBOutlet weak var tblMyEarnings: UITableView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var vwTotalEarning: UIView!
    //MARK:- Variables And Properties:-
    

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "My Earnings", leftImage: "Back", rightImages: [], isTranslucent: true)
        vwTotalEarning.addGeneralShaddow()
        tblMyEarnings.delegate = self
        tblMyEarnings.dataSource = self
        let uinib = UINib(nibName: MyEarningsCell.className, bundle: nil)
        tblMyEarnings.register(uinib, forCellReuseIdentifier: MyEarningsCell.className)
        vwTotalEarning.layer.cornerRadius = 9
        imgBackground.layer.cornerRadius = 9
        let buttonHeight = vwTotalEarning.frame.height
           let buttonWidth = vwTotalEarning.frame.width

           let shadowSize: CGFloat = 15
           let contactRect = CGRect(x: -shadowSize, y: buttonHeight - (shadowSize * 0.2), width: buttonWidth + shadowSize * 2, height: shadowSize)
//        vwTotalEarning.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
//        vwTotalEarning.layer.shadowRadius = 5
//        vwTotalEarning.layer.shadowOpacity = 0.6
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        vwTotalEarning.addBlueShadow()
//    }
}
//MARK:- UITableView Delegate and Data Sourse Methods
extension MyEarningsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMyEarnings.dequeueReusableCell(withIdentifier: MyEarningsCell.className) as! MyEarningsCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    
}
