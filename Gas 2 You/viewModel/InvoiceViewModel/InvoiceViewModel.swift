//
//  JobViewModel.swift
//  Gas 2 You Driver
//
//  Created by Tej on 01/10/21.
//

import Foundation

class InvoiceViewModel{
    
    weak var completedJobsVC : CompletedJobsVC? = nil
    weak var jobDetailsViewController : JobDetailsViewController? = nil

    func webserviceOrderStatusUpdateAPI(reqModel: DownloadInvoiceReqModel){
        Utilities.showHud()
        WebServiceSubClass.downloadInvoiceAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                self.completedJobsVC?.savePdf(urlString: response?.invoiceUrl ?? "", fileName: response?.invoiceNumber ?? "")
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
    func webserviceOrderStatusUpdateFromJobAPI(reqModel: DownloadInvoiceReqModel){
        Utilities.showHud()
        WebServiceSubClass.downloadInvoiceAPI(reqModel: reqModel) { (status, apiMessage, response, error) in
            if status{
                self.jobDetailsViewController?.setupTitleForDownload()
                self.jobDetailsViewController?.savePdf(urlString: response?.invoiceUrl ?? "", fileName: response?.invoiceNumber ?? "")
            }else{
                Toast.show(title: UrlConstant.Failed, message: apiMessage, state: .failure)
            }
        }
    }
    
  
}
