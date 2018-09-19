//
//  PaginationTests.swift
//  CoinbaseTests
//
//  Created by Red Davis on 19/09/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import XCTest
@testable import Coinbase


internal final class PagiationTests: XCTestCase
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
    
    internal func testQueryURL()
    {
        let baseURL = URL(string: "https://red.to")!
        let pagination = CoinbaseAPIClient.Pagination(startingAfter: "aaa", endingBefore: "bbb", limit: 40, order: .ascending)
        do
        {
            let url = try pagination.queryURL(baseURL: baseURL)
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let items = urlComponents.queryItems else
            {
                XCTFail("Invalid URL")
                return
            }
            
            var startingAfterValid = false
            var endingBeforeValid = false
            var limitValid = false
            var orderValid = false
            
            for item in items
            {
                switch item.name
                {
                case "starting_after" where item.value == "aaa":
                    startingAfterValid = true
                case "ending_before" where item.value == "bbb":
                    endingBeforeValid = true
                case "limit" where item.value == "40":
                    limitValid = true
                case "order" where item.value == "asc":
                    orderValid = true
                default:()
                }
            }
            
            XCTAssert(startingAfterValid, "Invalid starting_after value")
            XCTAssert(endingBeforeValid, "Invalid ending_before value")
            XCTAssert(limitValid, "Invalid limit value")
            XCTAssert(orderValid, "Invalid order value")
        }
        catch
        {
            XCTFail(error.localizedDescription)
        }
    }
}
