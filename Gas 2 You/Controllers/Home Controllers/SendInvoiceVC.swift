//
//  SendInvoiceVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 11/08/21.
//

import UIKit

class SendInvoiceVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblLocation: themeLabel!
    @IBOutlet weak var lblDate: themeLabel!
    @IBOutlet weak var vwMain: UIView!
    
    @IBOutlet weak var lblInvoiceNo: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    //MARK:- Variables and Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true
        
    }
    
    //MARK:- Custome Methods
    
    //MARK:- IBAction
    
}
