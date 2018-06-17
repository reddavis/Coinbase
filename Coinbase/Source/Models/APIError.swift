//
//  CoinbaseError.swift
//  Quids
//
//  Created by Red Davis on 31/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct APIError: Error, Decodable
    {
        // Static
        public static let unknown = APIError(identifier: .unknown, message: "Unknown error", url: nil)
        
        // Public
        public let identifier: Identifier
        public let message: String
        public let url: URL?
        
        public var localizedDescription: String {
            return self.message
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.APIError
{
    internal enum CodingKeys: String, CodingKey
    {
        case identifier = "id"
        case message
        case url
    }
}


// MARK: Identifier

public extension CoinbaseAPIClient.APIError
{
    public enum Identifier: String, Decodable
    {
        case unknown
        case twoFactorRequired = "two_factor_required"
        case missingParameter = "param_required"
        case validationError = "validation_error"
        case invalidRequest = "invalid_request"
        case personalDetailsRequired = "personal_details_required"
        case identityVerificationRequired = "identity_verification_required"
        case documentVerificationRequired = "jumio_verification_required"
        case documentAndFaceVerificationRequired = "jumio_face_match_verification_required"
        case unverifiedEmail = "unverified_email"
        case invalidAuth = "authentication_error"
        case invalidToken = "invalid_token"
        case revokedToken = "revoked_token"
        case expiredToken = "expired_token"
        case invalidScope = "invalid_scope"
        case noteFound = "not_found"
        case rateLimiExceeded = "rate_limit_exceeded"
        case publicServerError = "public_server_error"
        case internalServerError = "internal_server_error"
    }
}
