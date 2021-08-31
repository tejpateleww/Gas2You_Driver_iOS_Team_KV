//
//  SendRequestToAdminPopUpVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 11/08/21.
//

import UIKit

class SendRequestToAdminPopUpVC: BaseVC {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vwBlur: UIView!
    
    //MARK:- Variables

    override func viewDidLoad(){
        super.viewDidLoad()
        vwBlur.layer.cornerRadius = 20
    }
    
    //MARK:- IBActions
    @IBAction func btnCloseTap(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
