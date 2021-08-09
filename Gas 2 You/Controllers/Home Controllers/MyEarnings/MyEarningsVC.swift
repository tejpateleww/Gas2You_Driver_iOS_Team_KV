//
//  MyEarningsVC.swift
//  Gas 2 You
//
//  Created by Harsh on 09/08/21.
//

import UIKit

class MyEarningsVC: BaseVC {
    
    //MARK:- IBOutlets:-
    
    //MARK:- Variables And Properties:-
    

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods

}
//MARK:- UITableView Delegate and Data Sourse Methods
extension MyEarningsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
