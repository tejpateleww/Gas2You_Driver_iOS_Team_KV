//
//  MyOrdersVC.swift
//  Gas 2 You
//
//  Created by MacMini on 11/08/21.
//

import UIKit
import PDFKit
import EasyTipView

class CompletedJobsVC: BaseVC {
    
    //MARK: - Outlets
    @IBOutlet weak var tblCompletedJobs: UITableView!
    
    //MARK: - property
    var CurrentPage = 1
    var arrBookings = [RequestBookingListDatum]()
    var isApiProcessing = false
    var isStopPaging = false
    var isTblReload = false
    var jobViewModel = JobViewModel()
    var invoiceViewModel = InvoiceViewModel()
    let refreshControl = UIRefreshControl()
    var pagingSpinner = UIActivityIndicatorView()
    
    var isLoading = true {
        didSet {
            self.tblCompletedJobs.isUserInteractionEnabled = !isLoading
            self.tblCompletedJobs.reloadData()
        }
    }
    
    //TipView
    var preferences = EasyTipView.Preferences()
    var tipView: EasyTipView?
    var timerHidePop : Timer?
    
    //MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.registerNib()
        self.addRefreshControl()
        self.addTableFooter()
        self.callComplateBookingAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let tipView = self.tipView {
            tipView.dismiss(withCompletion: {
                self.tipView = nil
            })
        }
        
        if(self.timerHidePop != nil){
            self.timerHidePop?.invalidate()
            self.timerHidePop = nil
        }
        
    }
    
    //MARK: - custom methods
    func prepareView(){
        
        self.delegate = self
        self.isLoading = true
        self.setNavigationBarInViewController(controller: self, naviColor: .clear, naviTitle: "Completed Jobs", leftImage: "Back", rightImages: [], isTranslucent: true)
        self.setUpPopTip()
        
        NotificationCenter.default.removeObserver(self, name: .refreshCompJobsScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadData), name: .refreshCompJobsScreen, object: nil)
    }
    
    @objc func ReloadData() {
        self.CurrentPage = 1
        self.isStopPaging = false
        self.isTblReload = false
        self.isLoading = true
        self.callComplateBookingAPI()
    }
    
    func addTableFooter(){
        if #available(iOS 13.0, *) {
            self.pagingSpinner = UIActivityIndicatorView(style: .medium)
        } else {
            self.pagingSpinner.style = .whiteLarge
        }
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
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
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
    
    //MARK: - TipView methods
    func setUpPopTip() {
        self.preferences.drawing.font = CustomFont.regular.returnFont(14)
        self.preferences.drawing.foregroundColor = UIColor.white
        self.preferences.drawing.backgroundColor = UIColor.init(hexString: "#1F79CD")
        self.preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
    }
    
    func showPopTip(index : IndexPath, sender: UIButton){
        if let tipView = self.tipView {
            tipView.dismiss(withCompletion: {
                self.tipView = nil
                self.timerHidePop?.invalidate()
                self.timerHidePop = nil
            })
        } else {
            let view = EasyTipView(text: self.arrBookings[index.row].note ?? "", preferences: self.preferences, delegate: self)
            view.show(forView: sender, withinSuperview: self.navigationController?.view)
            self.tipView = view
        }
    }
    
    func startTimer() {
        if(self.timerHidePop == nil){
            self.timerHidePop = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                if let tipView = self.tipView {
                    tipView.dismiss(withCompletion: {
                        self.tipView = nil
                        self.timerHidePop?.invalidate()
                        self.timerHidePop = nil
                    })
                }
            })
        }
    }
    
}

//MARK: - UITableView Delegate methods
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
                cell.lblCarModelColor.text = "\(self.arrBookings[indexPath.row].modelName ?? "")" + " (" + "\(self.arrBookings[indexPath.row].modelYear ?? "")" + ")"
                cell.lblServiceType.text = self.arrBookings[indexPath.row].mainServiceName ?? ""
                let VehicleName = "\(self.arrBookings[indexPath.row].makeName ?? "")" + " (" + "\(self.arrBookings[indexPath.row].plateNumber ?? "")" + ")"
                cell.lblCarName.text = VehicleName
                cell.lblAddress.text = self.arrBookings[indexPath.row].parkingLocation ?? ""
                let DateTime = "\(self.arrBookings[indexPath.row].time ?? "")" + ", " + "\(self.arrBookings[indexPath.row].date ?? "")"
                cell.lblDateTime.text = DateTime
                
                if(self.pdfFileAlreadySaved(url: self.arrBookings[indexPath.row].invoiceUrl ?? "", fileName: self.arrBookings[indexPath.row].invoiceNumber ?? "") == true){
                    cell.btnDownload.setTitle("VIEW INVOICE", for: .normal)
                }else{
                    cell.btnDownload.setTitle("DOWNLOAD INVOICE", for: .normal)
                }
                
                cell.btnDownloadTapCousure = {
                    if(self.pdfFileAlreadySaved(url: self.arrBookings[indexPath.row].invoiceUrl ?? "", fileName: self.arrBookings[indexPath.row].invoiceNumber ?? "") == true){
                        self.savePdf(urlString: self.arrBookings[indexPath.row].invoiceUrl ?? "", fileName: self.arrBookings[indexPath.row].invoiceNumber ?? "")
                    }else{
                        self.callDownloadInvoiceAPI(bookingID: self.arrBookings[indexPath.row].id ?? "")
                    }
                }
                
                cell.btnNotes.isHidden = (self.arrBookings[indexPath.row].note == "")
                cell.btnNotesTapCousure = {
                    self.showPopTip(index: indexPath, sender: cell.btnNotes)
                    self.startTimer()
                    self.tblCompletedJobs.isScrollEnabled = false
                }
                
                return cell
            }else{
                let NoDatacell = self.tblCompletedJobs.dequeueReusableCell(withIdentifier: "NoDataTableViewCell", for: indexPath) as! NoDataTableViewCell
                if #available(iOS 13.0, *) {
                    NoDatacell.imgNoData.image = UIImage(named: "ic_MyOrders")?.withTintColor(UIColor.init(hexString: "#1F79CD"))
                } else {
                    NoDatacell.imgNoData.image = UIImage(named: "ic_MyOrders")?.withRenderingMode(.alwaysTemplate)
                    NoDatacell.imgNoData.tintColor = UIColor.init(hexString: "#1F79CD")
                }
                NoDatacell.lblNoDataTitle.text = "No completed order available"
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
        if(self.arrBookings.count > 0){
            let vc : JobDetailsViewController = JobDetailsViewController.instantiate(fromAppStoryboard: .Main)
            vc.isfromhome = false
            vc.strTitle = "Job Completed"
            vc.BookingDetail = self.arrBookings[indexPath.row]
            vc.orderStaus = "completed"
            vc.delegateDownloadInvoice = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: .systemBackground)
        } else {
            cell.setTemplateWithSubviews(isLoading, animate: true, viewBackgroundColor: UIColor.lightGray.withAlphaComponent(0.3))
        }
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
    
    func callDownloadInvoiceAPI(bookingID: String){
        self.invoiceViewModel.completedJobsVC = self
        
        let downloadInvoiceReqModel = DownloadInvoiceReqModel()
        downloadInvoiceReqModel.bookingId = bookingID
        
        self.invoiceViewModel.webserviceOrderStatusUpdateAPI(reqModel: downloadInvoiceReqModel)
    }
}

//MARK:- IncomingRideRequestViewDelegate
extension CompletedJobsVC : CompletedTripDelgate{
    func onSaveInvoice() {
        self.tblCompletedJobs.reloadData()
    }
}

extension CompletedJobsVC : DownloadInvoiceDelgate{
    func onCancelTripConfirm() {
        self.CurrentPage = 1
        self.callComplateBookingAPI()
    }
}


extension CompletedJobsVC : EasyTipViewDelegate {
    func easyTipViewDidTap(_ tipView: EasyTipView) {
        self.tblCompletedJobs.isScrollEnabled = true
    }
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        self.tblCompletedJobs.isScrollEnabled = true
        self.tipView = nil
        self.timerHidePop?.invalidate()
        self.timerHidePop = nil
    }
    
    
}
