//
//  Pagination.swift
//  Coinbase
//
//  Created by Red Davis on 17/09/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Pagination: Decodable
    {
        // Public
        public let startingAfter: String?
        public let endingBefore: String?
        public let order: Order?
        public let limit: Int?
        public let previousURI: String?
        public let nextURI: String?
        
        // MARK: Initialization
        
        public init(startingAfter: String?, endingBefore: String?, limit: Int?, order: Order?)
        {
            self.startingAfter = startingAfter
            self.endingBefore = endingBefore
            self.limit = limit
            self.order = order
            self.previousURI = nil
            self.nextURI = nil
        }
        
        // MARK: Query
        
        internal func queryURL(baseURL: URL) throws -> URL
        {
            guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else
            {
                throw QueryError.invalidURL
            }
            
            var queryItems = [URLQueryItem]()
            if let unwrappedLimit = self.limit
            {
                let item = URLQueryItem(name: "limit", value: String(unwrappedLimit))
                queryItems.append(item)
            }
            
            if let unwrappedOrder = self.order
            {
                let item = URLQueryItem(name: "order", value: unwrappedOrder.rawValue)
                queryItems.append(item)
            }
            
            if let startingAfter = self.startingAfter
            {
                let item = URLQueryItem(name: "starting_after", value: startingAfter)
                queryItems.append(item)
            }
            
            if let endingBefore = self.endingBefore
            {
                let item = URLQueryItem(name: "ending_before", value: endingBefore)
                queryItems.append(item)
            }
            
            urlComponents.queryItems = queryItems
            guard let url = urlComponents.url else
            {
                throw QueryError.invalidURL
            }
            
            return url
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Pagination
{
    internal enum CodingKeys: String, CodingKey
    {
        case startingAfter = "starting_after"
        case endingBefore = "ending_before"
        case order
        case limit
        case previousURI = "previous_uri"
        case nextURI = "next_uri"
    }
}


// MARK: Query Errors

public extension CoinbaseAPIClient.Pagination
{
    public enum QueryError: Error
    {
        case invalidURL
    }
}
