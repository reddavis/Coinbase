//
//  CoinbaseAuth.swift
//  Quids
//
//  Created by Red Davis on 22/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Auth: Codable
    {
        // Public
        public let accessToken: String
        public let refreshToken: String
        public let expiresAt: Date
        public let createdAt: Date
        public let scopes: [String]
        
        // MARK: Initialization
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.accessToken = try container.decode(String.self, forKey: .accessToken)
            self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
            
            self.createdAt = (try? container.decode(Date.self, forKey: .createdAt)) ?? Date()
            
            let expiresInSeconds = try container.decode(TimeInterval.self, forKey: .expiresAt)
            self.expiresAt = Date(timeInterval: expiresInSeconds, since: self.createdAt)
            
            let scopeValue = try container.decode(String.self, forKey: .scopes)
            self.scopes = scopeValue.split(separator: " ").map({ (substring) -> String in
                return String(substring)
            })
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Auth
{
    internal enum CodingKeys: String, CodingKey
    {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_in"
        case createdAt
        case scopes = "scope"
    }
}
