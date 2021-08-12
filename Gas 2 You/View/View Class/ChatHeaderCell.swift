//
//  ChatHeaderCell.swift
//  Gas 2 You Driver
//
//  Created by Apple on 13/08/21.
//

import UIKit

class ChatHeaderCell: UITableViewCell {

    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var lblTime: themeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainVW.layer.cornerRadius = self.layer.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
