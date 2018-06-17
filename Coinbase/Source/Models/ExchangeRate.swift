//
//  CoinbaseExchangeRate.swift
//  Quids
//
//  Created by Red Davis on 13/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct ExchangeRate: Decodable
    {
        // Public
        public let currencyCode: String
        public let rates: [String : Double]
        
        // MARK: Initialization
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.currencyCode = try container.decode(String.self, forKey: .currencyCode)
            
            self.rates = try container.decode([String : String].self, forKey: .rates).reduce(into: [String : Double](), { (result, keyValue) in
                guard let rate = Double(keyValue.value) else
                {
                    throw DecodingError.dataCorruptedError(forKey: .rates, in: container, debugDescription: "Rate incorrect format")
                }
                
                result[keyValue.key] = rate
            })
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.ExchangeRate
{
    internal enum CodingKeys: String, CodingKey
    {
        case currencyCode = "currency"
        case rates
    }
}
