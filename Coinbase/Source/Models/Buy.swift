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
        public let transaction: Resource?
        public let paymentMethod: Resource?
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
        case transaction
        case paymentMethod = "payment_method"
    }
}
