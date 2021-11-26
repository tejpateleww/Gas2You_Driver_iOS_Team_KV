//
//  UserListCell.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 25/11/21.
//

import UIKit
import UIView_Shimmer

class UserListCell: UITableViewCell, ShimmeringViewProtocol {

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
