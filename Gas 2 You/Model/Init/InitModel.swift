//
//  InitResponseModel.swift
//  PickARide User
//
//  Created by apple on 7/7/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
class InitResponseModel: Codable {
    let status: Bool?

    init(status: Bool) {
        self.status = status
    }
}
