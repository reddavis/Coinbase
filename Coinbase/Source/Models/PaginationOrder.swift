//
//  PaginationOrder.swift
//  Coinbase
//
//  Created by Red Davis on 17/09/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient.Pagination
{
    public enum Order: String, Decodable
    {
        case descending = "desc"
        case ascending = "asc"
    }
}
