//
//  Secure3DVerification.swift
//  Coinbase
//
//  Created by Red Davis on 09/08/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public extension CoinbaseAPIClient
{
    public struct Secure3DVerification: Decodable
    {
        // Public
        public let baseURL: URL
        public let payload: [[String : String]]
        public let url: URL
        
        // MARK: Initialization
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.baseURL = try container.decode(URL.self, forKey: .baseURL)
            self.payload = try container.decode([[String : String]].self, forKey: .payload)
            
            guard var urlComponents = URLComponents(url: self.baseURL, resolvingAgainstBaseURL: false) else
            {
                throw DecodingError.dataCorruptedError(forKey: .baseURL, in: container, debugDescription: "Invalid URL")
            }
            
            urlComponents.queryItems = self.payload.compactMap({ (dictionary) -> URLQueryItem? in
                guard let name = dictionary["name"],
                      let value = dictionary["value"] else
                {
                    return nil
                }
                
                return URLQueryItem(name: name, value: value)
            })
            
            guard let url = urlComponents.url else
            {
                throw DecodingError.dataCorruptedError(forKey: .baseURL, in: container, debugDescription: "Invalid URL")
            }
            
            self.url = url
        }
    }
}


// MARK: Coding keys

internal extension CoinbaseAPIClient.Secure3DVerification
{
    internal enum CodingKeys: String, CodingKey
    {
        case baseURL = "url"
        case payload
    }
}
