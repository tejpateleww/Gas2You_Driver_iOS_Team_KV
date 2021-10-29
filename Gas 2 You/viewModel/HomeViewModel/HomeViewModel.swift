//
//  HomeViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 20/09/21.
//

import Foundation
import UIKit

class HomeViewModel{
    
    weak var homeVC : HomeVC? = nil
    
    func webserviceBookingRequestAPI(reqModel: HomeBookingReqModel){
        DispatchQueue.main.async {
            self.homeVC?.refreshControl.endRefreshing()
        }
        self.homeVC?.isApiProcessing = true
        if(self.homeVC?.CurrentPage != 1){
            self.homeVC?.tblHome.tableFooterView?.isHidden = false
            self.homeVC?.pagingSpinner.startAnimating()
        }
        
        WebServiceSubClass.homeBookingRequest(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.homeVC?.isApiProcessing = false
            self.homeVC?.isTblReload = true
            self.homeVC?.isLoading = false
            if(self.homeVC?.CurrentPage != 1){
                self.homeVC?.tblHome.tableFooterView?.isHidden = true
                self.homeVC?.pagingSpinner.stopAnimating()
            }
            
            if status{
                if(response?.data?.count == 0){
                    if(self.homeVC?.CurrentPage == 1){
                        self.homeVC?.arrBookings = response?.data ?? []
                        self.homeVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.homeVC?.isStopPaging = true
                    }
                }else{
                    if(self.homeVC?.CurrentPage == 1){
                        self.homeVC?.arrBookings = response?.data ?? []
                    }else{
                        self.homeVC?.arrBookings.append(contentsOf: response?.data ?? [])
                    }
                }
                self.homeVC?.tblHome.reloadData()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
            
        }
    }
    
    func webserviceBookingInProgressAPI(reqModel: HomeBookingReqModel){
        
        DispatchQueue.main.async {
            self.homeVC?.refreshControl.endRefreshing()
        }
        self.homeVC?.isApiProcessing = true
        if(self.homeVC?.CurrentPageInProgress != 1){
            self.homeVC?.tblHome.tableFooterView?.isHidden = false
            self.homeVC?.pagingSpinner.startAnimating()
        }

        WebServiceSubClass.homeBookingInProgressAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            self.homeVC?.isApiProcessing = false
            self.homeVC?.isTblReload = true
            self.homeVC?.isLoading = false
            if(self.homeVC?.CurrentPageInProgress != 1){
                self.homeVC?.tblHome.tableFooterView?.isHidden = true
                self.homeVC?.pagingSpinner.stopAnimating()
            }
            
            if status{
                if(response?.data?.count == 0){
                    if(self.homeVC?.CurrentPageInProgress == 1){
                        self.homeVC?.arrBookings = response?.data ?? []
                        self.homeVC?.isStopPaging = true
                    }else{
                        print("End of Pagination...")
                        self.homeVC?.isStopPaging = true
                    }
                }else{
                    if(self.homeVC?.CurrentPageInProgress == 1){
                        self.homeVC?.arrBookings = response?.data ?? []
                    }else{
                        self.homeVC?.arrBookings.append(contentsOf: response?.data ?? [])
                    }
                }
                self.homeVC?.tblHome.reloadData()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
    
    
}
