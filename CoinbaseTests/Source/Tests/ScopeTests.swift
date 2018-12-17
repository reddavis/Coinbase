//
//  ScopeTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 17/12/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class ScopeTests: XCTestCase
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
    
    internal func testDecoding()
    {
        let decoder = JSONDecoder()
        let scopes = CoinbaseAPIClient.Scope.allCases
        for scope in scopes
        {
            do
            {
                // Use an array as JSONDecoder doesn't currently allow fragments
                let rawValue = [scope.value()]
                let data = try JSONSerialization.data(withJSONObject: rawValue, options: [])
                
                let decodedScopes = try decoder.decode([CoinbaseAPIClient.Scope].self, from: data)
                
                guard let decodedScope = decodedScopes.first else
                {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(decodedScope, scope)
            }
            catch
            {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
