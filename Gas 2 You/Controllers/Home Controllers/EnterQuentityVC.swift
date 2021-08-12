//
//  EnterQuentityVC.swift
//  Gas 2 You Driver
//
//  Created by Harsh on 12/08/21.
//

import UIKit

class EnterQuentityVC: BaseVC {
    
    //MARK:-IBOutlets
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var txtPrice: themeTextfield!
    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var btnCancel: ThemeButton!
    @IBOutlet weak var lblEnterQuentity: themeLabel!
    
    //MARK:- Variables

    override func viewDidLoad() {
        super.viewDidLoad()
        vwMain.layer.cornerRadius = 20
        vwMain.layer.masksToBounds = true

    }
    
    //MARK:- Custom Methods
    
    //MARK:- IBActions
    @IBAction func btnSubmitTap(_ sender: Any) {
    }
    @IBAction func btnCancelTap(_ sender: Any) {
    }
    
}
