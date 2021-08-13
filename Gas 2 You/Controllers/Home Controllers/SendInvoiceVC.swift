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
    @IBOutlet weak var lblDateData: themeLabel!
    @IBOutlet weak var lblTimeData: themeLabel!
    @IBOutlet weak var lblInvoiceData: themeLabel!
    @IBOutlet weak var lblItem: themeLabel!
    
    @IBOutlet weak var btnSendInvoice: ThemeButton!
    @IBOutlet weak var lblAmount: themeLabel!
    @IBOutlet weak var lblPrice: themeLabel!
    @IBOutlet weak var lblQuentity: UIView!
    @IBOutlet weak var lblPlatnumberData: themeLabel!
    @IBOutlet weak var lblPlatNumber: themeLabel!
    @IBOutlet weak var lblInvoiceNo: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    //MARK:- Variables and Properties
    
    var btnSubmitTapClosure : (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true
        
    }
    
    //MARK:- Custome Methods
    
    //MARK:- IBAction
    
    @IBAction func btnSendInvoiceTap(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            if let obj = self.btnSubmitTapClosure{
                obj()
            }
        })
    }
}
