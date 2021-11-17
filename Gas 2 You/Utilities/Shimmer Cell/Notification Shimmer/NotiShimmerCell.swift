//
//  NotiShimmerCell.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 17/11/21.
//

import UIKit
import UIView_Shimmer

class NotiShimmerCell: UITableViewCell , ShimmeringViewProtocol {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblNoti: UILabel!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.imgIcon,
            self.lblNoti
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
