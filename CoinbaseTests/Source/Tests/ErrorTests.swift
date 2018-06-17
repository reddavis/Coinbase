//
//  CoinbaseErrorTests.swift
//  QuidsTests
//
//  Created by Red Davis on 31/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class ErrorTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseError.json")
            
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.APIError.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    internal func testPaginationInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "CoinbaseErrors.json")
            
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.ErrorResponse.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
