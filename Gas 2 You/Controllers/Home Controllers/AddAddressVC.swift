//
//  AddAddressVC.swift
//  Gas 2 You
//
//  Created by MacMini on 09/08/21.
//

import UIKit

class AddAddressVC: BaseVC {

    @IBOutlet weak var addressListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "Address", controller: self)
    }
    
    @IBAction func addAdressBtnPressed(_ sender: ThemeButton) {
        
    }
    
}

extension AddAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addressListTV.dequeueReusableCell(withIdentifier: "cell") as! AddressCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
   
    
}
