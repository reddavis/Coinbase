//
//  CoinbaseNetwork.swift
//  Quids
//
//  Created by Red Davis on 25/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Network: Decodable
    {
        // Public
        public let numberOfConfirmations: Int?
        public let hash: String?
        public let status: String
        public let transactionAmount: Amount?
        public let transactionFee: Amount?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Network
{
    internal enum CodingKeys: String, CodingKey
    {
        case numberOfConfirmations = "confirmations"
        case hash
        case status
        case transactionAmount = "transaction_amount"
        case transactionFee = "transaction_feed"
    }
}
