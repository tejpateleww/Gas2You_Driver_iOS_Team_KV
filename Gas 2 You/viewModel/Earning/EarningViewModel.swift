//
//  EarningViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 25/11/21.
//

import Foundation

class EarningViewModel{
    
    weak var myEarningsVC : MyEarningsVC? = nil

    func webserviceEarningListAPI(reqModel: EarningReqModel){
        WebServiceSubClass.getEarningListApi(reqModel: reqModel) { (status, apiMessage, response, error) in
            DispatchQueue.main.async {
                self.myEarningsVC?.refreshControl.endRefreshing()
            }
            self.myEarningsVC?.isLoading = false
            self.myEarningsVC?.isTblReload = true
            if status{
                self.myEarningsVC?.lblTotalEarningsPrice.text = "$\(response?.totalEarning ?? "0.0")"
                self.myEarningsVC?.arrEarning = response?.data ?? []
                self.myEarningsVC?.tblMyEarnings.reloadData()
            }else{
                Toast.show(title: UrlConstant.Error, message: apiMessage, state: .failure)
            }
        }
    }
}
