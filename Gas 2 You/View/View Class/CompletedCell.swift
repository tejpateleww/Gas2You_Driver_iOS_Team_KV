//
//  CompletedCell.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit
import UIView_Shimmer

class CompletedCell: UITableViewCell, ShimmeringViewProtocol {

    //MARK:- IBOutlets
    @IBOutlet weak var lblTopHalf: themeLabel!
    @IBOutlet weak var lblServiceType: themeLabel!
    @IBOutlet weak var lblCarName: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblDateTime: themeLabel!
    @IBOutlet weak var btnDownload: ThemeButton!
    
    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var imgAddress: UIImageView!
    @IBOutlet weak var imgDateTime: UIImageView!
    
    @IBOutlet weak var imgCarModel: UIImageView!
    @IBOutlet weak var lblCarModelColor: themeLabel!
    
    
    //MARK:- Variables
    var btnDownloadTapCousure : (()->())?
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.lblTopHalf,
            self.lblServiceType,
            self.lblCarName,
            self.lblAddress,
            self.lblDateTime,
            self.lblCarModelColor,
            self.btnDownload,
            self.imgService,
            self.imgCarModel,
            self.imgCar,
            self.imgAddress,
            self.imgDateTime
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTopHalf.layer.masksToBounds = true
        lblTopHalf.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    @IBAction func btnDownloadTap(_ sender: UIButton) {
        if let obj = self.btnDownloadTapCousure{
            obj()
        }
    }
}
