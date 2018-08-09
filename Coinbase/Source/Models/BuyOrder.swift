//
//  BuyTemplate.swift
//  Coinbase
//
//  Created by Red Davis on 09/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct BuyOrder: Encodable
    {
        // Public
        public var amount: Double?
        public var total: Double?
        public var currency: String?
        public var paymentMethod: String?
        public var agreeBTCAmountVaries: Bool?
        public var commit: Bool?
        public var quote: Bool?
        
        // MARK: Initialization
        
        public init()
        {
            
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.BuyOrder
{
    internal enum CodingKeys: String, CodingKey
    {
        case amount
        case total
        case currency
        case paymentMethod = "payment_method"
        case agreeBTCAmountVaries = "agree_btc_amount_varies"
        case commit
        case quote
    }
}
