//
//  ChatMessageCell.swift
//  Gas 2 You Driver
//
//  Created by Apple on 13/08/21.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    @IBOutlet weak var mainVW: UIView!
    @IBOutlet weak var lblMessage: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
