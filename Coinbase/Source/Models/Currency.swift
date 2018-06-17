//
//  CoinbaseCurrency.swift
//  Quids
//
//  Created by Red Davis on 24/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Currency: Decodable
    {
        // Public
        public let regex: String?
        public let code: String
        public let hexColor: String
        public let exponent: Int
        public let name: String
        public let type: CurrencyType
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Currency
{
    internal enum CodingKeys: String, CodingKey
    {
        case regex = "address_regex"
        case code
        case hexColor = "color"
        case name
        case type
        case exponent
    }
}
