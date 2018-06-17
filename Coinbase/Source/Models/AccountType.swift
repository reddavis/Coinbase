//
//  CoinbaseAccountType.swift
//  Quids
//
//  Created by Red Davis on 23/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum AccountType: String, Codable
    {
        case vault
        case wallet
        case fiat
    }
}
