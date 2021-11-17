//
//  ChatShimmer.swift
//  Gas 2 You Driver
//
//  Created by Tej on 25/10/21.
//

import UIKit
import UIView_Shimmer

class ChatShimmer: UITableViewCell , ShimmeringViewProtocol {
    
    @IBOutlet weak var vWHeader: UIView!
    @IBOutlet weak var vWReceiver: UIView!
    @IBOutlet weak var vWSender: UIView!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.vWHeader,
            self.vWReceiver,
            self.vWSender,
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
