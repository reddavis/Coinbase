//
//  SellTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 13/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class SellTests: XCTestCase
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
    
    internal func testQuoteInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "SellQuote.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Sell.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    internal func testNonCommitInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "SellNonCommit.json")

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let _ = try decoder.decode(CoinbaseAPIClient.Sell.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }

    internal func testInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "Sell.json")

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let _ = try decoder.decode(CoinbaseAPIClient.Sell.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
