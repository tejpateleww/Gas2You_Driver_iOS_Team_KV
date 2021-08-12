//
//  JobDetailsViewController.swift
//  SideMenuDemo
//
//  Created by Apple on 12/08/21.
//

import UIKit

enum StartJobButtonTitle {
    case StartJob
    case FilledUp
    case CompleteJob
    
    var Name:String {
        switch self {
        case .StartJob:
            return "Start Job"
        case .FilledUp:
            return "Filled Up"
        case .CompleteJob:
            return "Complete Job"
        }
    }
}

class JobDetailsViewController: BaseVC {

    // ----------------------------------------------------
    // MARK: - --------- Variables ---------
    // ----------------------------------------------------
    
    
    // ----------------------------------------------------
    // MARK: - --------- IBOutlets ---------
    // ----------------------------------------------------
    @IBOutlet weak var LblFilledGallon: themeLabel!
    @IBOutlet weak var ViewFilledGallon: UIView!
    
    @IBOutlet weak var LblDateTime: themeLabel!
    @IBOutlet weak var ViewDateTime: UIView!
    
    
    @IBOutlet weak var BtnStartJob: ThemeButton!
    @IBOutlet weak var ImgViewOntheway: UIImageView!
    
    @IBOutlet weak var ImgViewJobDone: UIImageView!
    // ----------------------------------------------------
    // MARK: - --------- Life-cycle Methods ---------
    // ----------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Job Details", leftImage: "Back", rightImages: [], isTranslucent: true)
        
        ViewDateTime.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    
    // ----------------------------------------------------
    // MARK: - --------- Custom Methods ---------
    // ----------------------------------------------------
    
    
    
    // ----------------------------------------------------
    // MARK: - --------- IBAction Methods ---------
    // ----------------------------------------------------
    
    @IBAction func BtnStartJob(_ sender: ThemeButton) {
        if sender.titleLabel?.text == StartJobButtonTitle.StartJob.Name {
            BtnStartJob.setTitle(StartJobButtonTitle.FilledUp.Name, for: .normal)
            ImgViewOntheway.image = UIImage(named: "ic_checkBoxUnSelected")
            ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            ViewDateTime.isHidden = false
        } else if sender.titleLabel?.text == StartJobButtonTitle.FilledUp.Name {
            BtnStartJob.setTitle(StartJobButtonTitle.CompleteJob.Name, for: .normal)
            ImgViewOntheway.image = UIImage(named: "ic_checkBoxUnSelected")
            ImgViewJobDone.image = UIImage(named: "ic_checkBoxSelected")
            ViewDateTime.isHidden = false
            ViewFilledGallon.isHidden = false
        } else if sender.titleLabel?.text == StartJobButtonTitle.CompleteJob.Name {
            
        }
    }
    
    
    // ----------------------------------------------------
    // MARK: - --------- Webservice Methods ---------
    // ----------------------------------------------------
    

}
