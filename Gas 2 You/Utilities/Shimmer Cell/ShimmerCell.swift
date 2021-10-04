//
//  ShimmerCell.swift
//  Gas 2 You Driver
//
//  Created by Tej on 04/10/21.
//

import UIKit
import UIView_Shimmer

class ShimmerCell: UITableViewCell, ShimmeringViewProtocol {
    
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
    
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    @IBOutlet weak var imgDateTime: UIImageView!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.lblFuelType,
            self.btnAccept,
            self.btnReject,
            self.lblVehicle,
            self.lblDateAndTime,
            self.imgService,
            self.imgCar,
            self.imgAddress,
            self.imgDateTime,
            self.lblAddress,
        ]
    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
