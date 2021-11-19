//
//  AddonCell.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 19/11/21.
//

import UIKit

class AddonCell: UITableViewCell {
    
    @IBOutlet weak var lblAddonTitile: themeLabel!
    @IBOutlet weak var lblAddonText: themeLabel!
    @IBOutlet weak var lblAddonPrice: themeLabel!
    @IBOutlet weak var vWHighLight: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
