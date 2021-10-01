//
//  CommonDataResponseModel.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 08/06/21.
//

import Foundation

//MARK: COMMON REQUEST MODEL

// MARK: - CardListReqModel
class CommonUserIdRequestModel: Codable {
    var customerID: String?
    
    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
    }
    
    init(customerID: String?) {
        self.customerID = customerID
    }
}

class CommonModel: Codable {
    var status: Bool?
    var message: String?
    
    init(status: Bool?, message: String?) {
        self.status = status
        self.message = message
    }
}
