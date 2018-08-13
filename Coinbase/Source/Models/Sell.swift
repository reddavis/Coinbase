//
//  Sell.swift
//  Coinbase
//
//  Created by Red Davis on 10/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Sell: Decodable
    {
        // Public
        public let identifier: String?
        public let status: BuyStatus
        public let fee: Amount
        public let amount: Amount
        public let total: Amount
        public let payoutAt: Date?
        public let committed: Bool?
        public let isInstant: Bool?
        public let paymentMethod: Resource?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Sell
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case status
        case fee
        case amount
        case total
        case payoutAt = "payout_at"
        case committed
        case isInstant = "instant"
        case paymentMethod = "payment_method"
    }
}
