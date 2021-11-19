//
//  OrderComplateService.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 19, 2021

import Foundation

class OrderComplateService : Codable {
    
    var descriptionField : String?
    var price : String?
    var title : String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case price = "price"
        case title = "title"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
}
