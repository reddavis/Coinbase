//
//  XCTest+Helpers.swift
//  Red Davis
//
//  Created by Red Davis on 13/09/2017.
//  Copyright © 2017 Red Davis. All rights reserved.
//

import XCTest


internal extension XCTest
{
    internal func loadMockData(filename: String) -> Data
    {
        let fileURL = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "")!
        return try! Data(contentsOf: fileURL)
    }
}
