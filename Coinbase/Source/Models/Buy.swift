//
//  Buy.swift
//  Coinbase
//
//  Created by Red Davis on 09/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Buy: Decodable
    {
        // Public
        public let identifier: String?
        public let status: BuyStatus
        public let fee: Amount
        public let amount: Amount
        public let total: Amount
        public let holdUntil: Date?
        public let numberOfHoldDays: Int
        public let requiresCompletionStep: Bool
        public let userReference: String?
        public let payoutAt: Date?
        public let committed: Bool?
        public let secure3DVerification: Secure3DVerification?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Buy
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case status
        case fee
        case amount
        case total
        case holdUntil = "hold_until"
        case numberOfHoldDays = "hold_days"
        case requiresCompletionStep = "requires_completion_step"
        case userReference = "user_reference"
        case payoutAt = "payout_at"
        case committed
        case secure3DVerification = "secure3d_verification"
    }
}


//{
//    "data": {
//        "id": null,
//        "status": "quote",
//        "payment_method": {
//            "id": "cd6c79a2-5936-59c3-b646-65dfe51fa610",
//            "resource": "payment_method",
//            "resource_path": "/v2/payment-methods/cd6c79a2-5936-59c3-b646-65dfe51fa610"
//        },
//        "transaction": null,
//        "user_reference": null,
//        "created_at": null,
//        "updated_at": null,
//        "resource": "buy",
//        "resource_path": null,
//        "fee": {
//            "amount": "0.30",
//            "currency": "GBP"
//        },
//        "amount": {
//            "amount": "0.00198000",
//            "currency": "BTC"
//        },
//        "total": {
//            "amount": "10.38",
//            "currency": "GBP"
//        },
//        "subtotal": {
//            "amount": "10.08",
//            "currency": "GBP"
//        },
//        "hold_until": null,
//        "hold_days": 0,
//        "is_first_buy": false,
//        "requires_completion_step": false
//}
