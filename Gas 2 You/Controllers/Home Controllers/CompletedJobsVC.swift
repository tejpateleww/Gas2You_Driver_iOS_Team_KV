//
//  MyOrdersVC.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit

class CompletedJobsVC: BaseVC {
    
    @IBOutlet weak var tblCompletedJobs: UITableView!
    
//    var isInProcess : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavbarrightButton()
        
        setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Complete Jobs", leftImage: "Back", rightImages: [], isTranslucent: true)
        let completedCellNib = UINib(nibName: CompletedCell.className, bundle: nil)
        tblCompletedJobs.register(completedCellNib, forCellReuseIdentifier: CompletedCell.className)
    }
}

extension CompletedJobsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
            let completedCell = tblCompletedJobs.dequeueReusableCell(withIdentifier: CompletedCell.className) as! CompletedCell
        completedCell.btnDownloadTapCousure = {
            let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
            vc.isfromhome = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
            return completedCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
//        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
