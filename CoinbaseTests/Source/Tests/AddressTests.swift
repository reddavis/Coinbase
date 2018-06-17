//
//  CoinbaseAddressTests.swift
//  QuidsTests
//
//  Created by Red Davis on 05/06/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class AddressTests: XCTestCase
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
            let data = self.loadMockData(filename: "CoinbaseAddress.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.Address.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
