//
//  NotificationCell.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 10/08/21.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var imgNotification: UIImageView!
    @IBOutlet weak var lblNotification: themeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
