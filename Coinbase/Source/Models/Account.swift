//
//  CoinbaseAccount.swift
//  Quids
//
//  Created by Red Davis on 23/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Account: Decodable
    {
        // Public
        public let identifier: String
        public let name: String
        public let type: AccountType
        public let currency: Currency
        public let balance: Amount
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Account
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case name
        case type
        case currency
        case balance
    }
}
