//
//  HomeVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import UIKit

class HomeVC: BaseVC {

    //MARK:- OUTLETS
    
    @IBOutlet weak var selectServiceButton: UIButton!
    @IBOutlet weak var gasServiceView: UIView!
    @IBOutlet var octaneButtons: [themeButton]!
    @IBOutlet weak var priceTagLabel: themeLabel!
    @IBOutlet weak var selectParkingLocationButton: UIButton!
    @IBOutlet weak var locationLabel: themeLabel!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet var timeSlotButtons: [themeButton]!
    @IBOutlet weak var selectVehicleButton: UIButton!
    @IBOutlet weak var checkTirePressureButton: UIButton!
    @IBOutlet weak var windshieldRefillButton: UIButton!
    
    
    
    //MARK:- GLOBAL PROPERTIES
    
    
    
    //MARK:- VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavbarrightButton()
        NavBarTitle(isOnlyTitle: false, isMenuButton: true, title: "Schedule Service", controller: self)
        
    }
    
    
    //MARK:- ACTIONS
    
    @IBAction func selectServiceButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func octaneButtonPressed(_ sender: themeButton) {
        
        switch sender.tag {
        case 0:
            deselectOtherOctaneButtons(tag: sender.tag)
            break
        case 1:
            deselectOtherOctaneButtons(tag: sender.tag)
            break
        default:
            break
        }
    }
    
    
    @IBAction func parkingLocatioButtonPressed(_ sender: UIButton) {
        let carParkingLocationVC = storyboard?.instantiateViewController(withIdentifier: "CarParkingLocationVC") as! CarParkingLocationVC
        navigationController?.pushViewController(carParkingLocationVC, animated: true)
    }
    
    @IBAction func timeSlotButtonPressed(_ sender: themeButton) {
        
        switch sender.tag {
        case 0:
            deselectOtherTimeSlot(tag: sender.tag)
            break
        case 1:
            deselectOtherTimeSlot(tag: sender.tag)
            break
        case 2:
            deselectOtherTimeSlot(tag: sender.tag)
            break
        case 3:
            deselectOtherTimeSlot(tag: sender.tag)
            break
        default:
            break
        }
        
    }
    
    @IBAction func selectVehicleButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func tirePressureButtonPressed(_ sender: UIButton) {
        checkTirePressureButton.isSelected.toggle()
        if checkTirePressureButton.isSelected {
            checkTirePressureButton.setImage(#imageLiteral(resourceName: "IC_selectedBlue"), for: .normal)
        } else {
            checkTirePressureButton.setImage(#imageLiteral(resourceName: "IC_unselectedBlue"), for: .normal)
        }
    }
    
    @IBAction func windShieldRefillButtonPressed(_ sender: UIButton) {
        windshieldRefillButton.isSelected.toggle()
        if windshieldRefillButton.isSelected {
            windshieldRefillButton.setImage(#imageLiteral(resourceName: "IC_selectedBlue"), for: .normal)
        } else {
            windshieldRefillButton.setImage(#imageLiteral(resourceName: "IC_unselectedBlue"), for: .normal)
        }
    }
    
    @IBAction func fillItUpButtonPressed(_ sender: ThemeButton) {
        
       
        
    }
    
    //MARK:- OTHER METHODS
    
    func deselectOtherTimeSlot(tag: Int) {
        
        for i in 0..<timeSlotButtons.count {
            if tag == i {
                timeSlotButtons[i].isSelected = true
            } else {
                timeSlotButtons[i].isSelected = false
            }
        }
    }
    
    func deselectOtherOctaneButtons(tag: Int) {
        
        for i in 0..<octaneButtons.count {
            if tag == i {
                octaneButtons[i].setImage(#imageLiteral(resourceName: "IC_selectedCheckGray"), for: .normal)
            } else {
                octaneButtons[i].setImage(#imageLiteral(resourceName: "IC_unselectedGray"), for: .normal)
            }
        }
    }
    
    
}

//MARK:- EXTENSIONS
