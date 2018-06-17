//
//  CoinbaseUser.swift
//  Quids
//
//  Created by Red Davis on 29/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct User: Decodable
    {
        // Public
        public let identifier: String
        public let avatarURL: URL
        public let bitcoinUnit: String?
        public let email: String?
        public let nativeCurrencyCode: String?
        public let name: String?
        public let bio: String?
        public let location: String?
        public let url: URL?
        public let username: String?
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.User
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case avatarURL = "avatar_url"
        case bitcoinUnit = "bitcoin_unit"
        case nativeCurrencyCode = "native_currency"
        case name
        case bio = "profile_bio"
        case location = "profile_location"
        case url = "profile_url"
        case username
        case email
    }
}
