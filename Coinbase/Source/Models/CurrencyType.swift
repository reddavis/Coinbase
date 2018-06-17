//
//  CoinbaseCurrencyType.swift
//  Quids
//
//  Created by Red Davis on 24/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum CurrencyType: String, Decodable
    {
        case crypto
        case fiat
    }
}
