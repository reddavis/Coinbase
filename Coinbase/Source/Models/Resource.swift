//
//  Resource.swift
//  Coinbase
//
//  Created by Red Davis on 13/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Resource: Decodable
    {
        // Public
        public let identifier: String
        public let name: String
        public let path: String
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Resource
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case name = "resource"
        case path = "resource_path"
    }
}
