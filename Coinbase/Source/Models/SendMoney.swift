//
//  SendMoney.swift
//  Coinbase
//
//  Created by Red Davis on 20/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct SendMoney: Encodable
    {
        // Public
        public let type = "send"
        public var to: String
        public var amount: String
        public var currencyCode: String
        public var description: String?
        public var skipNotifications: Bool?
        public var fee: String?
        public var idem: String?
        public var toFinancialInstitution: Bool?
        public var financialInstitutionWebsite: String?
        
        // MARK: Initialization
        
        public init(to: String, amount: Double, currencyCode: String)
        {
            self.to = to
            self.amount = String(amount)
            self.currencyCode = currencyCode
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.SendMoney
{
    internal enum CodingKeys: String, CodingKey
    {
        case type
        case to
        case amount
        case currencyCode = "currency"
        case description
        case skipNotifications = "skip_notifications"
        case fee
        case idem
        case toFinancialInstitution = "to_financial_institution"
        case financialInstitutionWebsite = "financial_institution_website"
    }
}
