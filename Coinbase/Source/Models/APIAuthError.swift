//
//  APIAuthError.swift
//  Coinbase
//
//  Created by Red Davis on 06/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct APIAuthError: Error, Decodable
    {
        // Static
        public static let unknown = APIAuthError(identifier: .unknown, description: "Unknown error")
        
        // Public
        public let identifier: Identifier
        public let description: String
        
        public var localizedDescription: String {
            return self.description
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.APIAuthError
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "error"
        case description = "error_description"
    }
}


// MARK: Identifier

public extension CoinbaseAPIClient.APIAuthError
{
    public enum Identifier: String, Decodable
    {
        case unknown
        case invalidGrant = "invalid_grant"
    }
}
