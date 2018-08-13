//
//  CoinbaseTransaction.swift
//  Quids
//
//  Created by Red Davis on 25/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Transaction: Decodable
    {
        // Public
        public let identifier: String
        public let status: TransactionStatus
        public let type: TransactionType
        public let amount: Amount
        public let nativeAmount: Amount
        public let description: String?
        public let createdAt: Date
        public let updatedAt: Date
        public let network: Network?
        public let buy: Resource?
        public let sell: Resource?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Transaction
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case status
        case type
        case amount
        case nativeAmount = "native_amount"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case network
        case buy
        case sell
    }
}
