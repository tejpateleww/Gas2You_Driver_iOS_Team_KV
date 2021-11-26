//
//  SendInvoiceVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 11/08/21.
//

import UIKit

class SendInvoiceVC: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblLocation: themeLabel!
    @IBOutlet weak var lblDate: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    @IBOutlet weak var lblPlatNumber: themeLabel!
    @IBOutlet weak var lblInvoiceNo: themeLabel!
    @IBOutlet weak var btnSendInvoice: ThemeButton!
    @IBOutlet weak var tblAddon: UITableView!
    @IBOutlet weak var tblAddonHeight: NSLayoutConstraint!

    //MARK:- Variables and Properties
    var btnSubmitTapClosure : (()->())?
    var BookingDetail : OrderComplateDatum?
    var arrService:[OrderComplateService] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.prepareView()
        self.setupData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblAddon.layer.removeAllAnimations()
        self.tblAddonHeight.constant = self.tblAddon.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
    }
    
    //MARK:- Custome Methods
    func prepareView(){
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true
        
        self.tblAddon.delegate = self
        self.tblAddon.dataSource = self
        self.tblAddon.separatorStyle = .none
        self.tblAddon.showsVerticalScrollIndicator = false
        self.tblAddon.isScrollEnabled = false
        self.tblAddon.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        self.arrService.append(contentsOf: self.BookingDetail?.services ?? [])
        self.tblAddon.reloadData()
    }
    
    func registerNib(){
        let nib = UINib(nibName: AddonCell.className, bundle: nil)
        self.tblAddon.register(nib, forCellReuseIdentifier: AddonCell.className)
    }
    
    func popBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupData(){
        self.lblLocation.text = self.BookingDetail?.parkingLocation ?? ""
        self.lblDate.text = "Date : \(self.BookingDetail?.date ?? "")"
        self.lblTime.text = "Time : \(self.BookingDetail?.time ?? "")"
        self.lblInvoiceNo.text = "Invoice No : \(self.BookingDetail?.invoiceNumber ?? "")"
        self.lblPlatNumber.text = "Plate Number : \(self.BookingDetail?.plateNumber ?? "")"
        
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

//MARK: - UITableview Methods
extension SendInvoiceVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrService.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblAddon.dequeueReusableCell(withIdentifier: AddonCell.className) as! AddonCell
        cell.selectionStyle = .none
        cell.vWHighLight.isHidden = true
        
        if(indexPath.row == 0){
            cell.lblAddonTitile.fontColor = UIColor(hexString: "1F79CD")
            cell.lblAddonText.fontColor = UIColor(hexString: "1F79CD")
            cell.lblAddonPrice.fontColor = UIColor(hexString: "1F79CD")
            
            cell.lblAddonTitile.text = "Item"
            cell.lblAddonText.text = "Qty & Rate"
            cell.lblAddonPrice.text = "Amount"
        }else{ 
            
            if(indexPath.row == self.arrService.count + 1){
                cell.lblAddonText.font = CustomFont.PoppinsSemiBold.returnFont(14)
                cell.lblAddonTitile.text = ""
                cell.lblAddonText.text = "Total"
                cell.lblAddonPrice.text = "$\(self.BookingDetail?.finalAmount ?? "")"
            }else{
                cell.lblAddonTitile.font = CustomFont.PoppinsRegular.returnFont(14)
                cell.lblAddonText.font = CustomFont.PoppinsRegular.returnFont(14)

                let newString = self.arrService[indexPath.row - 1].title?.replacingOccurrences(of: "/", with: "\n")
                let newString1 = self.arrService[indexPath.row - 1].descriptionField?.replacingOccurrences(of: "/", with: "\n")
                cell.lblAddonTitile.text = newString ?? ""
                cell.lblAddonText.text = newString1 ?? ""
                
                if(self.arrService[indexPath.row - 1].price == "FREE"){
                    cell.lblAddonPrice.text = "\(self.arrService[indexPath.row - 1].price ?? "")"
                }else{
                    cell.lblAddonPrice.text = "$\(self.arrService[indexPath.row - 1].price ?? "")"
                }
                
                if(indexPath.row == self.arrService.count){
                    cell.vWHighLight.isHidden = false
                }
            }
            

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
