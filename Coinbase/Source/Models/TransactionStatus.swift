//
//  CoinbaseTransactionStatus.swift
//  Quids
//
//  Created by Red Davis on 25/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum TransactionStatus: String, Decodable
    {
        case pending
        case completed
        case failed
        case expired
        case cancelled
        case waitingForSignature = "waiting_for_signature"
        case waitingForClearing = "waiting_for_clearing"
        case unknown
    }
}
