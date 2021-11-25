//
//  EarningResDatum.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 25, 2021

import Foundation

class EarningResDatum : Codable {

        let amount : String?
        let date : String?
        let id : String?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case date = "date"
                case id = "id"
        }
    
    required init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                amount = try values.decodeIfPresent(String.self, forKey: .amount)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                id = try values.decodeIfPresent(String.self, forKey: .id)
        }

}
