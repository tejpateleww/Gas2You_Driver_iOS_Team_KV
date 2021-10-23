//
//  JobViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 01/10/21.
//

import Foundation

class JobViewModel{
    
    weak var JobDetailsVC : JobDetailsViewController? = nil
    weak var completedJobsVC : CompletedJobsVC? = nil
    
    func webserviceOrderStatusUpdateAPI(reqModel: JobStatusUpdateReqModel){
        Utilities.showHud()
        WebServiceSubClass.OrderStatusUpdateAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
                self.JobDetailsVC?.popBack()
            }
        }
    }
    
    func webserviceOrderCompAPI(reqModel: JobCompReqModel){
        Utilities.showHud()
        WebServiceSubClass.OrderCompAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            Utilities.hideHud()
            if status{
                
                self.JobDetailsVC?.CompBookingDetail = response?.data
                self.JobDetailsVC?.JobCompleted()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
                self.JobDetailsVC?.popBack()
            }
        }
    }
    
    func webserviceCompBookingHistoryAPI(reqModel: HomeBookingReqModel){
        DispatchQueue.main.async {
            self.completedJobsVC?.refreshControl.endRefreshing()
        }
        self.completedJobsVC?.isApiProcessing = true
        if(self.completedJobsVC?.CurrentPage != 1){
            self.completedJobsVC?.pagingSpinner.startAnimating()
            //Utilities.showHud()
        }
        WebServiceSubClass.complateBookingAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            if(self.completedJobsVC?.CurrentPage != 1){
                self.completedJobsVC?.pagingSpinner.stopAnimating()
                //Utilities.hideHud()
            }
            self.completedJobsVC?.isLoading = false
            self.completedJobsVC?.isApiProcessing = false
            self.completedJobsVC?.isTblReload = true
            if status{
                if(response?.data?.count == 0){
                    if(self.completedJobsVC?.CurrentPage == 1){
                        self.completedJobsVC?.arrBookings = response?.data ?? []
                        self.completedJobsVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.completedJobsVC?.isStopPaging = true
                    }
                }else{
                    if(self.completedJobsVC?.CurrentPage == 1){
                        self.completedJobsVC?.arrBookings = response?.data ?? []
                    }else{
                        self.completedJobsVC?.arrBookings.append(contentsOf: response?.data ?? [])
                    }
                }
                self.completedJobsVC?.tblCompletedJobs.reloadData()
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
}
