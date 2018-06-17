//
//  CoinbaseExchangeRateTests.swift
//  QuidsTests
//
//  Created by Red Davis on 13/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class ExchangeRateTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseExchangeRate.json")
            
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.ExchangeRate.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
