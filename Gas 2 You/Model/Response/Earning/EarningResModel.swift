//
//  EarningResModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 25, 2021

import Foundation

class EarningResModel : Codable {

        let data : [EarningResDatum]?
        let message : String?
        let status : Bool?
        let totalEarning : String?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
                case totalEarning = "total_earning"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent([EarningResDatum].self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Bool.self, forKey: .status)
                totalEarning = try values.decodeIfPresent(String.self, forKey: .totalEarning)
        }

}
