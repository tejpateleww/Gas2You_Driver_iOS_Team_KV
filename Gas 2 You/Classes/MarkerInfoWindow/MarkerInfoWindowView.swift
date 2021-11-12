//
//  MarkerInfoWindowView.swift
//  Gas 2 You
//
//  Created by Gaurang on 03/09/21.
//

import UIKit

class MarkerInfoWindowView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgArrowHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadNib()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.setAllSideContraints(.zero)
        // Fit view size to content size
        frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
