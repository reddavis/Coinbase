//
//  CoinbaseAddress.swift
//  Quids
//
//  Created by Red Davis on 05/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Address: Decodable
    {
        // Public
        public let identifier: String
        public let value: String
        public let network: String
        public let createdAt: Date
        public let name: String?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Address
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case value = "address"
        case network
        case createdAt = "created_at"
        case name
    }
}
