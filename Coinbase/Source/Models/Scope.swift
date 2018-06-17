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
    public enum Scope: String
    {
        case readAccounts = "wallet:accounts:read"
        case updateAccounts = "wallet:accounts:update"
        case createAccounts = "wallet:accounts:create"
        case deleteAccounts = "wallet:accounts:delete"
        case readAddresses = "wallet:addresses:read"
        case createAddresses = "wallet:addresses:create"
        case readBuys = "wallet:buys:read"
        case createBuys = "wallet:buys:create"
        case readCheckouts = "wallet:checkouts:read"
        case createCheckouts = "wallet:checkouts:create"
        case readDeposits = "wallet:deposits:read"
        case createDeposits = "wallet:deposits:create"
        case readNotifications = "wallet:notifications:read"
        case readOrders = "wallet:orders:read"
        case createOrders = "wallet:orders:create"
        case refundOrders = "wallet:orders:refund"
        case readPaymentMethods = "wallet:payment-methods:read"
        case deletePaymentMethods = "wallet:payment-methods:delete"
        case readPaymentMethodLimits = "wallet:payment-methods:limits"
        case readSells = "wallet:sells:read"
        case createSells = "wallet:sells:create"
        case readTransactions = "wallet:transactions:read"
        case createTransactions = "wallet:transactions:send"
        case requestTransactions = "wallet:transactions:request"
        case transferFunds = "wallet:transactions:transfer"
        case readUser = "wallet:user:read"
        case updateUser = "wallet:user:update"
        case readUserEmailAddress = "wallet:user:email"
        case readWithdrawals = "wallet:withdrawals:read"
        case createWithdrawals = "wallet:withdrawals:create"
    }
}
