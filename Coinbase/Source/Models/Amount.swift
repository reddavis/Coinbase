//
//  CoinbaseBalance.swift
//  Quids
//
//  Created by Red Davis on 23/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Amount: Decodable
    {
        // Public
        public let currencyCode: String
        public let amount: Double
        
        // MARK: Initialization
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.currencyCode = try container.decode(String.self, forKey: .currencyCode)
            
            let amountString = try container.decode(String.self, forKey: .amount)
            guard let amount = Double(amountString) else
            {
                throw DecodingError.dataCorruptedError(forKey: .amount, in: container, debugDescription: "Amount incorrect format")
            }
            
            self.amount = amount
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Amount
{
    internal enum CodingKeys: String, CodingKey
    {
        case currencyCode = "currency"
        case amount
    }
}
