//
//  PaymentMethodTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 07/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class PaymentMethodTests: XCTestCase
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
    
    internal func testPaginationInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "CoinbaseFetchPaymentMethods.json")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let _ = try decoder.decode(CoinbaseAPIClient.PaginationResponse<CoinbaseAPIClient.PaymentMethod>.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
