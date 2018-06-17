//
//  CoinbaseTransactionTests.swift
//  QuidsTests
//
//  Created by Red Davis on 25/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class TransactionTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseTransaction.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Transaction.self, from: data)
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
            let data = self.loadMockData(filename: "CoinbaseFetchTransactions.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.PaginationResponse<CoinbaseAPIClient.Transaction>.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
