//
//  AuthTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 17/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class AuthTests: XCTestCase
{
    // MARK: Setup
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: -
    
    internal func testSingularInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "CoinbaseAuth.json")
            
            let decoder = JSONDecoder()
            let auth = try decoder.decode(CoinbaseAPIClient.Auth.self, from: data)
            
            // Values
            XCTAssertEqual(auth.scopes.count, 8)
            XCTAssert(auth.expiresAt > Date())
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: Encoding
    
    internal func testEncodingDecoding()
    {
        do
        {
            var data = self.loadMockData(filename: "CoinbaseAuth.json")
            
            let decoder = JSONDecoder()
            let authOne = try decoder.decode(CoinbaseAPIClient.Auth.self, from: data)
            
            // Encode
            let encoder = JSONEncoder()
            data = try encoder.encode(authOne)
            
            // Decode
            let authTwo = try decoder.decode(CoinbaseAPIClient.Auth.self, from: data)
            
            // Asserts
            XCTAssertEqual(authOne.expiresAt, authTwo.expiresAt)
            XCTAssertEqual(authOne.createdAt, authTwo.createdAt)
            XCTAssertEqual(authOne.accessToken, authTwo.accessToken)
            XCTAssertEqual(authOne.refreshToken, authTwo.refreshToken)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
