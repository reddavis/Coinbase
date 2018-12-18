//
//  AuthInformationTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 17/12/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class AuthInformationTests: XCTestCase
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
    
    internal func testInitialization()
    {
        do
        {
            let data = self.loadMockData(filename: "AuthInformation.json")
            
            let decoder = JSONDecoder()
            let _ = try decoder.decode(CoinbaseAPIClient.AuthInformation.self, from: data)
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
