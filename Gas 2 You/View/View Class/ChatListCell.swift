//
//  ChatListCell.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit
import UIView_Shimmer

class ChatListCell: UITableViewCell, ShimmeringViewProtocol {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblMsg: themeLabel!
    @IBOutlet weak var lblUserName: themeLabel!
    @IBOutlet weak var lblTime: themeLabel!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.userImg,
            self.lblMsg,
            self.lblUserName,
            self.lblTime,
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImg.layer.cornerRadius = self.userImg.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
