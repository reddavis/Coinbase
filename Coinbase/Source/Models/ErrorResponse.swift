//
//  CoinbaseErrorResponse.swift
//  Quids
//
//  Created by Red Davis on 31/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


internal extension CoinbaseAPIClient
{
    internal struct ErrorResponse: Decodable
    {
        // Internal
        internal let errors: [APIError]
    }
}
