//
//  PaymentMethodType.swift
//  Coinbase
//
//  Created by Red Davis on 07/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum PaymentMethodType: String, Decodable
    {
        case ach = "ach_bank_account"
        case sepa = "sepa_bank_account"
        case ideal = "ideal_bank_account"
        case coinbaseFiatAccount = "fiat_account"
        case bankWire = "bank_wire"
        case creditCard = "credit_card"
        case secure3DCard = "secure3d_card"
        case eft = "eft_bank_account"
        case interac = "interac"
    }
}
