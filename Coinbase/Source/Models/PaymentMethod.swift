//
//  PaymentMethod.swift
//  Coinbase
//
//  Created by Red Davis on 07/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct PaymentMethod: Decodable
    {
        // Public
        public let identifier: String
        public let type: PaymentMethodType
        public let name: String
        public let currencyCode: String
        public let isPrimaryBuyMethod: Bool
        public let isPrimarySellMethod: Bool
        public let isBuyingAllowed: Bool
        public let isSellingAllowed: Bool
        public let isInstantBuyingAllowed: Bool
        public let isInstantSellingAllowed: Bool
        public let isWithdrawingAllowed: Bool
        public let isDepositingAllowed: Bool
        public let createdAt: Date
        public let updatedAt: Date
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.PaymentMethod
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case type
        case name
        case currencyCode = "currency"
        case isPrimaryBuyMethod = "primary_buy"
        case isPrimarySellMethod = "primary_sell"
        case isBuyingAllowed = "allow_buy"
        case isSellingAllowed = "allow_sell"
        case isInstantBuyingAllowed = "instant_buy"
        case isInstantSellingAllowed = "instant_sell"
        case isWithdrawingAllowed = "allow_withdraw"
        case isDepositingAllowed = "allow_deposit"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

