//
//  CoinbaseTransactionType.swift
//  Quids
//
//  Created by Red Davis on 25/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public enum TransactionType: String, Decodable
    {
        case buy
        case send
        case request
        case transfer
        case sell
        case fiatDeposit = "fiat_deposit"
        case fiatWithdrawal = "fiat_withdrawal"
        case exchangeDeposit = "exchange_deposit"
        case exchangeWithdrawal = "exchange_withdrawal"
        case vaultWithdrawal = "vault_withdrawal"
        case unknown
    }
}
