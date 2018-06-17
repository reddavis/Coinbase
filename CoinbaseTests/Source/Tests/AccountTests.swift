//
//  CoinbaseAccountTests.swift
//  QuidsTests
//
//  Created by Red Davis on 23/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class AccountTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseAccount.json")
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.Account.self, from: data)
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
            let data = self.loadMockData(filename: "CoinbaseFetchAccounts.json")
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.PaginationResponse<CoinbaseAPIClient.Account>.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
