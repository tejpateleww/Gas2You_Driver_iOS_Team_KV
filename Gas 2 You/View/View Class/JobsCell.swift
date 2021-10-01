//
//  JobsCell.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 09/08/21.
//

import UIKit

class JobsCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var stackbtn: UIStackView!
    @IBOutlet weak var lblFuelType: themeLabel!
    @IBOutlet weak var btnAccept: ThemeButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var btnReject: ThemeButton!
    @IBOutlet weak var lblVehicle: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var vwButtons: UIView!
    @IBOutlet weak var lblDateAndTime: themeLabel!
    @IBOutlet weak var stackButtomHeight: NSLayoutConstraint!
    
    //MARK:- Variables and Properties
    var btnAcceptTapClosure : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        vwMain.layer.cornerRadius = 15
//        vwButtons.layer.masksToBounds = true
        
//        vwButtonsHeight.constant = 0
//        vwMain.layer.masksToBounds = true
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //vwButtons.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAcceptTap(_ sender: Any) {
        if let obj = btnAcceptTapClosure{
            obj()
        }
        
    }
    @IBAction func btnRejectTap(_ sender: Any) {
        
    }
    
}
