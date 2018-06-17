//
//  CoinbaseSingularResponse.swift
//  Quids
//
//  Created by Red Davis on 29/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension CoinbaseAPIClient
{
    internal struct SingularResponse<T: Decodable>: Decodable
    {
        // Internal
        internal let object: T
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.SingularResponse
{
    internal enum CodingKeys: String, CodingKey
    {
        case object = "data"
    }
}
