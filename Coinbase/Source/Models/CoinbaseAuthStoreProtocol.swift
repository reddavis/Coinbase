//
//  CoinbaseAuthStoreProtocol.swift
//  Quids
//
//  Created by Red Davis on 22/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public protocol CoinbaseAPIClientAuthStore: class
{
    var auth: CoinbaseAPIClient.Auth? { get set }
    var isAuthenticated: Bool { get }
    var hasExpired: Bool { get }
    
    func delete()
}



public extension CoinbaseAPIClientAuthStore
{
    public var isAuthenticated: Bool {
        return self.auth != nil
    }
    
    public var hasExpired: Bool {
        guard let unwrappedAuth = self.auth else
        {
            return true
        }
        
        return unwrappedAuth.expiresAt < Date()
    }
    
    public func delete()
    {
        self.auth = nil
    }
}
