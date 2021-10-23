//
//  MyOrdersVC.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit

class CompletedJobsVC: BaseVC {
    
    @IBOutlet weak var tblCompletedJobs: UITableView!
    
    var CurrentPage = 1
    var arrBookings = [RequestBookingListDatum]()
    var isApiProcessing = false
    var isStopPaging = false
    var isTblReload = false
    var jobViewModel = JobViewModel()
    let refreshControl = UIRefreshControl()
    var pagingSpinner = UIActivityIndicatorView()
    
    var isLoading = true {
        didSet {
            self.tblCompletedJobs.isUserInteractionEnabled = !isLoading
            self.tblCompletedJobs.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.registerNib()
        self.addRefreshControl()
        self.addTableFooter()
        self.callComplateBookingAPI()
    }
    
    func prepareView(){
        self.isLoading = true
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Completed Jobs", leftImage: "Back", rightImages: [], isTranslucent: true)
    }
    
    func addTableFooter(){
        self.pagingSpinner = UIActivityIndicatorView(style: .medium)
        self.pagingSpinner.stopAnimating()
        self.pagingSpinner.color = UIColor.init(hexString: "#1F79CD")
        self.pagingSpinner.hidesWhenStopped = true
        self.tblCompletedJobs.tableFooterView = self.pagingSpinner
        self.tblCompletedJobs.tableFooterView?.isHidden = true
    }
    
    func registerNib(){
        let completedCellNib = UINib(nibName: CompletedCell.className, bundle: nil)
        self.tblCompletedJobs.register(completedCellNib, forCellReuseIdentifier: CompletedCell.className)
        let nib1 = UINib(nibName: NoDataTableViewCell.className, bundle: nil)
        self.tblCompletedJobs.register(nib1, forCellReuseIdentifier: NoDataTableViewCell.className)
    }
    
    func addRefreshControl(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        self.refreshControl.tintColor = UIColor.init(hexString: "#1F79CD")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblCompletedJobs.addSubview(self.refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.CurrentPage = 1
        self.isStopPaging = false
        self.isTblReload = false
        self.isLoading = true
        self.callComplateBookingAPI()
    }
}

extension CompletedJobsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrBookings.count > 0 {
            return self.arrBookings.count
        } else {
            return (isTblReload) ? 1 : 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblCompletedJobs.dequeueReusableCell(withIdentifier: CompletedCell.className) as! CompletedCell
        
        if(!isTblReload){
            cell.lblServiceType.text = "Fill-ups"
            cell.lblCarName.text = "Suzuki (GJ 21 HG 2121)"
            cell.lblAddress.text = "iSquare, Shukan Cross Road, Science City Rd, Sola, Ahmedabad, Gujarat"
            cell.lblDateTime.text = "2021-10-01 07:07:06"
            return cell
        }else{
            if self.arrBookings.count != 0 {
                cell.lblServiceType.text = self.arrBookings[indexPath.row].mainServiceName ?? ""
                let VehicleName = "\(self.arrBookings[indexPath.row].makeName ?? "")" + " (" + "\(self.arrBookings[indexPath.row].plateNumber ?? "")" + ")"
                cell.lblCarName.text = VehicleName
                cell.lblAddress.text = self.arrBookings[indexPath.row].parkingLocation ?? ""
                let DateTime = "\(self.arrBookings[indexPath.row].time ?? "")" + ", " + "\(self.arrBookings[indexPath.row].date ?? "")"
                cell.lblDateTime.text = DateTime
                
                
                cell.btnDownloadTapCousure = {
                    let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
                    vc.isfromhome = false
                    vc.strTitle = "Job Completed"
                    vc.BookingDetail = self.arrBookings[indexPath.row]
                    vc.orderStaus = "completed"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            }else{
                let NoDatacell = self.tblCompletedJobs.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                return NoDatacell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!isTblReload){
            return UITableView.automaticDimension
        }else{
            if self.arrBookings.count != 0 {
                return UITableView.automaticDimension
            }else{
                return tableView.frame.height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
        vc.isfromhome = false
        vc.strTitle = "Job Completed"
        vc.BookingDetail = self.arrBookings[indexPath.row]
        vc.orderStaus = "completed"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tblCompletedJobs.contentOffset.y >= (self.tblCompletedJobs.contentSize.height - self.tblCompletedJobs.frame.size.height)) && self.isStopPaging == false && self.isApiProcessing == false {
            print("call from scroll..")
            self.CurrentPage += 1
            self.callComplateBookingAPI()
        }
    }
}

//MARK:- Api Calls
extension CompletedJobsVC{
    
    func callComplateBookingAPI(){
        self.jobViewModel.completedJobsVC = self
        
        let HomeBooking = HomeBookingReqModel()
        HomeBooking.page = "\(self.CurrentPage)"
        
        self.jobViewModel.webserviceCompBookingHistoryAPI(reqModel: HomeBooking)
    }
}
