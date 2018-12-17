//
//  AuthMetadata.swift
//  Coinbase
//
//  Created by Red Davis on 17/12/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct AuthMetadata
    {
        // Public
        public let sendLimitAmount: Double?
        public let sendLimitCurrency: String?
        public let sendLimitPeriod: Scope.SendLimitPeriod?
    }
}

// MARK: Decodable

extension CoinbaseAPIClient.AuthMetadata: Decodable
{
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Send amount
        if let sendAmountString = try container.decodeIfPresent(String.self, forKey: .sendLimitAmount)
        {
            guard let sendAmount = Double(sendAmountString) else
            {
                throw DecodingError.typeMismatch(Double.self, DecodingError.Context(codingPath: [CodingKeys.sendLimitAmount], debugDescription: "Invalid amount"))
            }
            
            self.sendLimitAmount = sendAmount
        }
        else
        {
            self.sendLimitAmount = nil
        }
        
        self.sendLimitCurrency = try container.decodeIfPresent(String.self, forKey: .sendLimitCurrency)
        self.sendLimitPeriod = try container.decodeIfPresent(CoinbaseAPIClient.Scope.SendLimitPeriod.self, forKey: .sendLimitPeriod)
    }
}



// MARK: Coding keys

internal extension CoinbaseAPIClient.AuthMetadata
{
    internal enum CodingKeys: String, CodingKey
    {
        case sendLimitAmount = "send_limit_amount"
        case sendLimitCurrency = "send_limit_currency"
        case sendLimitPeriod = "send_limit_period"
    }
}
