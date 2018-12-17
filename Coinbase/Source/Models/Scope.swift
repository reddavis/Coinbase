//
//  CoinbaseScope.swift
//  Quids
//
//  Created by Red Davis on 30/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum Scope: Equatable
    {
        case readAccounts
        case updateAccounts
        case createAccounts
        case deleteAccounts
        case readAddresses
        case createAddresses
        case readBuys
        case createBuys
        case readCheckouts
        case createCheckouts
        case readDeposits
        case createDeposits
        case readNotifications
        case readOrders
        case createOrders
        case refundOrders
        case readPaymentMethods
        case deletePaymentMethods
        case readPaymentMethodLimits
        case readSells
        case createSells
        case readTransactions
        case createTransactions(sendLimit: Double?, currencyCode: String?, period: SendLimitPeriod?)
        case requestTransactions
        case transferFunds
        case readUser
        case updateUser
        case readUserEmailAddress
        case readWithdrawals
        case createWithdrawals
        
        // MARK: Initialization
        
        internal init?(value: String)
        {
            let stringValues = CoinbaseAPIClient.Scope.allCases.map { (scope) -> String in
                return scope.value()
            }
            
            guard let index = stringValues.index(of: value) else
            {
                return nil
            }
            
            self = CoinbaseAPIClient.Scope.allCases[index]
        }
        
        // MARK: Key
        
        internal func value() -> String
        {
            switch self
            {
            case .readAccounts:
                return "wallet:accounts:read"
            case .updateAccounts:
                return "wallet:accounts:update"
            case .createAccounts:
                return "wallet:accounts:create"
            case .deleteAccounts:
                return "wallet:accounts:delete"
            case .readAddresses:
                return "wallet:addresses:read"
            case .createAddresses:
                return "wallet:addresses:create"
            case .readBuys:
                return "wallet:buys:read"
            case .createBuys:
                return "wallet:buys:create"
            case .readCheckouts:
                return "wallet:checkouts:read"
            case .createCheckouts:
                return "wallet:checkouts:create"
            case .readDeposits:
                return "wallet:deposits:read"
            case .createDeposits:
                return "wallet:deposits:create"
            case .readNotifications:
                return "wallet:notifications:read"
            case .readOrders:
                return "wallet:orders:read"
            case .createOrders:
                return "wallet:orders:create"
            case .refundOrders:
                return "wallet:orders:refund"
            case .readPaymentMethods:
                return "wallet:payment-methods:read"
            case .deletePaymentMethods:
                return "wallet:payment-methods:delete"
            case .readPaymentMethodLimits:
                return "wallet:payment-methods:limits"
            case .readSells:
                return "wallet:sells:read"
            case .createSells:
                return "wallet:sells:create"
            case .readTransactions:
                return "wallet:transactions:read"
            case .createTransactions:
                return "wallet:transactions:send"
            case .requestTransactions:
                return "wallet:transactions:request"
            case .transferFunds:
                return "wallet:transactions:transfer"
            case .readUser:
                return "wallet:user:read"
            case .updateUser:
                return "wallet:user:update"
            case .readUserEmailAddress:
                return "wallet:user:email"
            case .readWithdrawals:
                return "wallet:withdrawals:read"
            case .createWithdrawals:
                return "wallet:withdrawals:create"
            }
        }
        
        // MARK: Metadata
        
        internal func metadata() -> [URLQueryItem]
        {
            switch self
            {
            case .createTransactions(let sendLimit, let currencyCode, let period):
                guard let unwrappedSendLimit = sendLimit,
                      let unwrappedCurrencyCode = currencyCode,
                      let unwrappedPeriod = period else
                {
                    return []
                }
                
                let sendLimitItem = URLQueryItem(name: "meta[send_limit_amount]", value: String(unwrappedSendLimit))
                let currencyItem = URLQueryItem(name: "meta[send_limit_currency]", value: unwrappedCurrencyCode)
                let periodItem = URLQueryItem(name: "meta[send_limit_period]", value: unwrappedPeriod.rawValue)
                
                return [sendLimitItem, currencyItem, periodItem]
            default:
                return []
            }
        }
    }
}

// MARK: CaseIterable

extension CoinbaseAPIClient.Scope: CaseIterable
{
    public static var allCases: [CoinbaseAPIClient.Scope] {
        return [
            .readAccounts,
            .updateAccounts,
            .createAccounts,
            .deleteAccounts,
            .readAddresses,
            .createAddresses,
            .readBuys,
            .createBuys,
            .readCheckouts,
            .createCheckouts,
            .readDeposits,
            .createDeposits,
            .readNotifications,
            .readOrders,
            .createOrders,
            .refundOrders,
            .readPaymentMethods,
            .deletePaymentMethods,
            .readPaymentMethodLimits,
            .readSells,
            .createSells,
            .readTransactions,
            .createTransactions(sendLimit: nil, currencyCode: nil, period: nil),
            .requestTransactions,
            .transferFunds,
            .readUser,
            .updateUser,
            .readUserEmailAddress,
            .readWithdrawals,
            .createWithdrawals
        ]
    }
}

// MARK: Decodable

extension CoinbaseAPIClient.Scope: Decodable
{
    public init(from decoder: Decoder) throws
    {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        guard let scope = CoinbaseAPIClient.Scope(value: value) else
        {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid scope \(value)")
        }
        
        self = scope
    }
}


// MARK: Send limit period

public extension CoinbaseAPIClient.Scope
{
    public enum SendLimitPeriod: String, Decodable
    {
        case day, month, year
    }
}
