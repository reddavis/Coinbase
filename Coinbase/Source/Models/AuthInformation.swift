//
//  AuthInformation.swift
//  Coinbase
//
//  Created by Red Davis on 17/12/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct AuthInformation: Decodable
    {
        // Public
        public let method: String
        public let scopes: [Scope]
        public let metadata: AuthMetadata
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.AuthInformation
{
    internal enum CodingKeys: String, CodingKey
    {
        case method
        case scopes
        case metadata = "oauth_meta"
    }
}
