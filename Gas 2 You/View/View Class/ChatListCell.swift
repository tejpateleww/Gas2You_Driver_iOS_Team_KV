//
//  ChatListCell.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var LblMessage: themeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileIV.layer.cornerRadius = profileIV.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
