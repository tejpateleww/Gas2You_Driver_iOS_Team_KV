//
//  MyEarningsCell.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 09/08/21.
//

import UIKit
import UIView_Shimmer

class MyEarningsCell: UITableViewCell, ShimmeringViewProtocol {

    //MARK:- IBOutlets
    
    @IBOutlet weak var lblPaymentDone: themeLabel!
    @IBOutlet weak var lblDate: themeLabel!
    @IBOutlet weak var imgCurrency: UIImageView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblAmount: themeLabel!
    //MARK:- Variables
    
    var shimmeringAnimatedItems: [UIView] {
        [
            self.imgCurrency,
            self.lblPaymentDone,
            self.lblDate,
            self.lblAmount
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwMain.layer.cornerRadius = 13
        
        vwMain.layer.shadowColor = UIColor.black.cgColor
        vwMain.layer.shadowOpacity = 0.3
        vwMain.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)// CGSize.zero
        vwMain.layer.shadowRadius = 2
        
        
        
        imgCurrency.layer.cornerRadius = imgCurrency.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    
}
extension UIView{
    @IBInspectable var shadow: Bool {
               get {
                   return layer.shadowOpacity > 0.0
               }
               set {
                   self.addShadow()
                   if newValue == true {
                       self.addShadow()
                   }else{
                       self.layer.shadowOpacity = 0.0
                   }
               }
           }
    @IBInspectable var blueShadow: Bool {
               get {
                   return layer.shadowOpacity > 0.0
               }
               set {
                   self.addBlueShadow()
                   if newValue == true {
                    self.addBlueShadow()
                   }else{
                       self.layer.shadowOpacity = 0.0
                   }
               }
           }
    func addGeneralShaddow() {
              self.layer.cornerRadius = 6.0
              self.clipsToBounds = true

              self.layer.masksToBounds = false
              self.layer.shadowColor = UIColor.lightGray.cgColor
    //          self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
              self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
              self.layer.shadowOpacity = 0.4
              self.layer.shadowRadius = 3.0
        }
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.7).cgColor,
                               shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                               shadowOpacity: Float = 0.8,
                               shadowRadius: CGFloat = 5.0) {
                layer.shadowColor = shadowColor
                layer.shadowOffset = shadowOffset
                layer.shadowOpacity = shadowOpacity
                layer.shadowRadius = shadowRadius
            }
    func addBlueShadow(shadowColor: CGColor = UIColor.init(hexString: "#468DE5").withAlphaComponent(0.7).cgColor,
                       shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0),
                               shadowOpacity: Float = 0.4,
                               shadowRadius: CGFloat = 3.0) {
                layer.shadowColor = shadowColor
                layer.shadowOffset = shadowOffset
                layer.shadowOpacity = shadowOpacity
                layer.shadowRadius = shadowRadius
            }
}
