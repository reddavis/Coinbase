//
//  AuthAPIErrorTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 06/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class AuthAPIErrorTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseAuthError.json")
            
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.APIAuthError.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
