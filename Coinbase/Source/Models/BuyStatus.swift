//
//  BuyStatus.swift
//  Coinbase
//
//  Created by Red Davis on 09/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum BuyStatus: String, Decodable
    {
        case created
        case completed
        case canceled
        case quote
    }
}
