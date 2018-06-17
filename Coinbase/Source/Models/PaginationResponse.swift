//
//  CoinbasePaginationResponse.swift
//  Quids
//
//  Created by Red Davis on 24/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension CoinbaseAPIClient
{
    internal struct PaginationResponse<T: Decodable>: Decodable
    {
        // Internal
        internal let objects: [T]
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.PaginationResponse
{
    internal enum CodingKeys: String, CodingKey
    {
        case objects = "data"
    }
}
