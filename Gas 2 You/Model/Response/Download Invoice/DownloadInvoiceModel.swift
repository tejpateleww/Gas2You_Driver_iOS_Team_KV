//
//  DownloadInvoiceModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 26, 2021

import Foundation

class DownloadInvoiceModel : Codable {
    
    let invoiceUrl : String?
    let invoiceNumber : String?
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case invoiceUrl = "invoice_url"
        case invoiceNumber = "invoice_number"
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        invoiceUrl = try values.decodeIfPresent(String.self, forKey: .invoiceUrl)
        invoiceNumber = try values.decodeIfPresent(String.self, forKey: .invoiceNumber)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
