//
//  UserRatingModel.swift
//  Gas 2 You Driver
//
//  Created by Tej P on 05/01/22.
//

import Foundation

class UserRatingResModel: Codable {
    var status: Bool?
    var message: String?
    var rating: String?
    
    init(status: Bool?, message: String?, rating: String?) {
        self.status = status
        self.message = message
        self.rating = rating
    }
}
