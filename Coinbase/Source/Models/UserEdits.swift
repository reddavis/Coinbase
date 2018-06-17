//
//  CoinbaseUserEdits.swift
//  Quids
//
//  Created by Red Davis on 29/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct UserEdits: Encodable
    {
        // Public
        public let nativeCurrencyCode: String?
        public let name: String?
        public let timeZone: String?
        
        // MARK: Initialization
        
        public init(nativeCurrencyCode: String?, name: String?, timeZone: String?)
        {
            self.nativeCurrencyCode = nativeCurrencyCode
            self.name = name
            self.timeZone = timeZone
        }
    }
}


// MARK: Coding keys

public extension CoinbaseAPIClient.UserEdits
{
    public enum CodingKeys: String, CodingKey
    {
        case nativeCurrencyCode = "native_currency"
        case name
        case timeZone = "time_zone"
    }
}
