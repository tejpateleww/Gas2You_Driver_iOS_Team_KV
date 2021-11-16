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
    @IBOutlet weak var lblAmount: themeLabel!
    @IBOutlet weak var lblPrice: themeLabel!
    @IBOutlet weak var lblPricePerGallon: themeLabel!
    @IBOutlet weak var btnSendInvoice: ThemeButton!
    @IBOutlet weak var lblQuentity: UIView!
    @IBOutlet weak var lblPlatnumberData: themeLabel!
    @IBOutlet weak var lblPlatNumber: themeLabel!
    @IBOutlet weak var lblInvoiceNo: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    
    //MARK:- Variables and Properties
    
    var btnSubmitTapClosure : (()->())?
    var BookingDetail : OrderComplateDatum?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.setupData()
    }
    
    //MARK:- Custome Methods
    func prepareView(){
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupData(){
        self.lblLocation.text = self.BookingDetail?.parkingLocation ?? ""
        self.lblDateData.text = " \(self.BookingDetail?.date ?? "")"
        self.lblTime.text = self.BookingDetail?.time ?? ""
        self.lblInvoiceData.text = " \(self.BookingDetail?.invoiceNumber ?? "")"
        self.lblPlatnumberData.text = " \(self.BookingDetail?.plateNumber ?? "")"
        self.lblItem.text = self.BookingDetail?.mainServiceName ?? ""
        self.lblAmount.text = self.BookingDetail?.finalAmount ?? ""
        self.lblPrice.text = "\(self.BookingDetail?.totalGallon ?? "")"
        self.lblPricePerGallon.text = "\(self.BookingDetail?.price ?? "") Per Gallon"
    }
    
    //MARK:- IBAction
    
    @IBAction func btnSendInvoiceTap(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            if let obj = self.btnSubmitTapClosure{
                obj()
            }
        })
    }
}
