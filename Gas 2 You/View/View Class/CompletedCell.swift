//
//  CompletedCell.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit

class CompletedCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var lblTopHalf: themeLabel!
    @IBOutlet weak var lblServiceType: themeLabel!
    @IBOutlet weak var lblCarName: themeLabel!
    @IBOutlet weak var lblAddress: themeLabel!
    @IBOutlet weak var lblDateTime: themeLabel!
    @IBOutlet weak var btnDownload: ThemeButton!
    
    
    //MARK:- Variables
    var btnDownloadTapCousure : (()->())?
    
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
