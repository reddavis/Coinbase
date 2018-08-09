//
//  BuyTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 09/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class BuyTests: XCTestCase
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
            let data = self.loadMockData(filename: "BuyQuote.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Buy.self, from: data)
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
            let data = self.loadMockData(filename: "BuyNonCommit.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Buy.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
    
    internal func testVerificationRequiredInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "BuyVerificationRequired.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Buy.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
