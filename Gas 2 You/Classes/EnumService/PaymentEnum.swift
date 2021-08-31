//
//  PaymentEnum.swift
//  PickARide User
//
//  Created by apple on 7/13/21.
//  Copyright © 2021 EWW071. All rights reserved.
//

import Foundation
import UIKit

enum PaymentsCardsTypesName : String{
    case wallet
    case visa
    case mastercard
    case amex
    case jcb
    case dinnerclub
    case discover
}

enum PaymentsCards {
    case wallet
    case visa
    case mastercard
    case amex
    case jcb
    case dinnerclub
    case discover
}

extension PaymentsCards: RawRepresentable{
    typealias RawValue = UIImage

    init?(rawValue: RawValue) {
        switch rawValue {
        case #imageLiteral(resourceName: "ic_wallet"): self = .wallet
        case #imageLiteral(resourceName: "ic_visa"): self = .visa
        case #imageLiteral(resourceName: "ic_masterCard"): self = .mastercard
        case #imageLiteral(resourceName: "AmexCard"): self = .amex
        case #imageLiteral(resourceName: "JCBCard"): self = .jcb
        case #imageLiteral(resourceName: "DinersCard"): self = .dinnerclub
        case #imageLiteral(resourceName: "ic_dummyDiscover"): self = .discover
        default: return nil
    }
}

var rawValue: RawValue {
        switch self {
        case .wallet: return #imageLiteral(resourceName: "ic_wallet")
        case .visa: return #imageLiteral(resourceName: "iconVisa")
        case .mastercard: return #imageLiteral(resourceName: "mastercard")
        case .amex: return #imageLiteral(resourceName: "AmexCard")
        case .jcb: return #imageLiteral(resourceName: "JCBCard")
        case .dinnerclub: return #imageLiteral(resourceName: "DinersCard")
        case .discover: return #imageLiteral(resourceName: "DiscoverCard")
        }
    }
}

func getCardTypeImage(type: String) -> UIImage{
    if type == PaymentsCardsTypesName.wallet.rawValue{
        return PaymentsCards.wallet.rawValue
    }else if type == PaymentsCardsTypesName.visa.rawValue{
        return PaymentsCards.visa.rawValue
    }else if type == PaymentsCardsTypesName.mastercard.rawValue{
        return PaymentsCards.mastercard.rawValue
    }else if type == PaymentsCardsTypesName.amex.rawValue{
        return PaymentsCards.amex.rawValue
    }else if type == PaymentsCardsTypesName.jcb.rawValue{
        return PaymentsCards.jcb.rawValue
    }else if type == PaymentsCardsTypesName.dinnerclub.rawValue{
        return PaymentsCards.dinnerclub.rawValue
    }else if type == PaymentsCardsTypesName.discover.rawValue{
        return PaymentsCards.discover.rawValue
    }
    return UIImage()
}
