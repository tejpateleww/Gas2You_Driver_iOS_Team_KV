//
//  CompletedCell.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit

class CompletedCell: UITableViewCell {

    @IBOutlet weak var lblTopHalf: themeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTopHalf.layer.masksToBounds = true
        lblTopHalf.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
