//
//  CoinbaseAPIClient.swift
//  Quids
//
//  Created by Red Davis on 22/05/2018.
//  Copyright © 2018 Red Davis. All rights reserved.
//

import Foundation


public protocol CoinbaseAPIClientDelegate: class
{
    func didFailToRefreshAuthToken(in client: CoinbaseAPIClient, with error: Error)
}


public final class CoinbaseAPIClient
{
    // Public
    public var isAuthenticated: Bool {
        return self.authStore.isAuthenticated
    }
    
    public weak var delegate: CoinbaseAPIClientDelegate?
    
    // Private
    private let clientID: String
    private let clientSecret: String
    private let authStore: CoinbaseAPIClientAuthStore
    private let session: URLSession
    
    private let baseURL = URL(string: "https://api.coinbase.com")!
    private let authBaseURL = URL(string: "https://coinbase.com")!
    
    private var defaultHeaders: [String : String] {
        var headers = [
            "Content-Type" : "application/json",
            "CB-VERSION" : "2018-05-22"
        ]
        
        if let auth = self.authStore.auth
        {
            headers["Authorization"] = "Bearer \(auth.accessToken)"
        }
        
        return headers
    }
    
    private var isRefreshingToken = false
    private var queuedRequests = [(() -> Void)]()
    
    // MARK: Initialization
    
    public required init(clientID: String, clientSecret: String, authStore: CoinbaseAPIClientAuthStore, session: URLSession = URLSession(configuration: .default))
    {
        self.session = session
        self.clientID = clientID
        self.authStore = authStore
        self.clientSecret = clientSecret
    }
    
    // MARK: Request
    
    private func perform(request: URLRequest, completionHandler: @escaping (_ json: Any?, _ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void)
    {
        if self.authStore.hasExpired && !self.isRefreshingToken
        {
            self.queueRequest(self.perform(request: request, completionHandler: completionHandler))
            
            self.refreshToken { [weak self] (success, error) in
                guard let weakSelf = self,
                      !success else
                {
                    return
                }
                
                let refreshError = error ?? CoinbaseAPIClient.APIError.unknown
                self?.delegate?.didFailToRefreshAuthToken(in: weakSelf, with: refreshError)
            }
            
            return
        }
        
        // Perform request
        let task = self.session.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let json: Any?
            
            if let unwrappedData = data
            {
                json = try? JSONSerialization.jsonObject(with: unwrappedData, options: [])
            }
            else
            {
                json = nil
            }
            
            completionHandler(json, data, httpResponse, error)
        }
        
        task.resume()
    }
}

// MARK: Error

private extension CoinbaseAPIClient
{
    private func buildErrors(data: Data?) -> [APIError]
    {
        let decoder = JSONDecoder()
        
        guard let unwrappedData = data,
              let response = try? decoder.decode(ErrorResponse.self, from: unwrappedData) else
        {
            return [APIError.unknown]
        }
        
        return response.errors
    }
    
    private func buildAuthError(data: Data?) -> APIAuthError
    {
        let decoder = JSONDecoder()
        
        guard let unwrappedData = data,
              let error = try? decoder.decode(APIAuthError.self, from: unwrappedData) else
        {
            return APIAuthError.unknown
        }
        
        return error
    }
}

// MARK: Auth

public extension CoinbaseAPIClient
{
    public func logout()
    {
        self.authStore.delete()
    }
    
    public func authorizeURL(scopes: [Scope]) -> URL
    {
        let baseURL = self.authBaseURL.appendingPathComponent("oauth/authorize")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        let responseTypeItem = URLQueryItem(name: "response_type", value: "code")
        let clientIDItem = URLQueryItem(name: "client_id", value: self.clientID)
        let allAccountsItem = URLQueryItem(name: "account", value: "all")
        
        // Scopes
        let scopeValues = scopes.map { (scope) -> String in
            return scope.value()
        }.joined(separator: ",")
        
        let scopeComponentItem = URLQueryItem(name: "scope", value: scopeValues)
        
        let metadataComponentItems = scopes.reduce(into: [URLQueryItem]()) { (result, scope) in
            result.append(contentsOf: scope.metadata())
        }
        
        // Set query items
        urlComponents.queryItems = [responseTypeItem, clientIDItem, scopeComponentItem, allAccountsItem] + metadataComponentItems
        
        return urlComponents.url!
    }
    
    public func authenticate(code: String, redirectURL: URL, completionHandler: @escaping (_ success: Bool, _ errors: [Error]?) -> Void)
    {
        let baseURL = self.baseURL.appendingPathComponent("oauth/token")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        let grantTypeItem = URLQueryItem(name: "grant_type", value: "authorization_code")
        let codeItem = URLQueryItem(name: "code", value: code)
        let clientIDItem = URLQueryItem(name: "client_id", value: self.clientID)
        let clientSecretItem = URLQueryItem(name: "client_secret", value: self.clientSecret)
        let redirectItem = URLQueryItem(name: "redirect_uri", value: redirectURL.absoluteString)
        urlComponents.queryItems = [grantTypeItem, codeItem, clientIDItem, clientSecretItem, redirectItem]
        
        // Perform request
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.isRefreshingToken = true
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            self?.isRefreshingToken = false
            
            guard let unwrappedData = data,
                  let weakSelf = self else
            {
                completionHandler(false, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                weakSelf.authStore.auth = try decoder.decode(Auth.self, from: unwrappedData)
                completionHandler(true, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(false, errors)
            }
        }
    }
    
    private func refreshToken(_ completionHandler: @escaping (_ success: Bool, _ error: Error?) -> Void)
    {
        guard let auth = self.authStore.auth else
        {
            return
        }
        
        self.isRefreshingToken = true
        
        // Build request
        let baseURL = self.baseURL.appendingPathComponent("oauth/token")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        
        let grantTypeItem = URLQueryItem(name: "grant_type", value: "refresh_token")
        let refreshTokenItem = URLQueryItem(name: "refresh_token", value: auth.refreshToken)
        let clientIDItem = URLQueryItem(name: "client_id", value: self.clientID)
        let clientSecretItem = URLQueryItem(name: "client_secret", value: self.clientSecret)
        urlComponents.queryItems = [grantTypeItem, refreshTokenItem, clientIDItem, clientSecretItem]
        
        // Perform request
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data,
                  let weakSelf = self else
            {
                completionHandler(false, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                weakSelf.authStore.auth = try decoder.decode(Auth.self, from: unwrappedData)
                
                // Run through queued requests
                weakSelf.isRefreshingToken = false
                
                for queuedRequest in weakSelf.queuedRequests
                {
                    queuedRequest()
                }
                
                weakSelf.queuedRequests.removeAll()
                
                completionHandler(true, nil)
            }
            catch
            {
                let error = self?.buildAuthError(data: data)
                completionHandler(false, error)
            }
        }
    }
    
    private func queueRequest(_ requestHandler: @escaping @autoclosure () -> Void)
    {
        self.queuedRequests.append(requestHandler)
    }
}

// MARK: Accounts

public extension CoinbaseAPIClient
{
    public func fetchAccounts(_ completionHandler: @escaping (_ accounts: [Account]?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.fetchAccounts(completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("v2/accounts")
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let paginationResponse = try decoder.decode(PaginationResponse<Account>.self, from: unwrappedData)
                completionHandler(paginationResponse.objects, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Transactions

public extension CoinbaseAPIClient
{
    public func fetchTransactions(accountID: String, pagination: Pagination?, completionHandler: @escaping (_ transactions: [Transaction]?, _ pagination: Pagination?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.fetchTransactions(accountID: accountID, pagination: pagination, completionHandler: completionHandler))
            return
        }
        
        // Build URL
        let baseURL = self.baseURL.appendingPathComponent("v2/accounts/\(accountID)/transactions")
        let url: URL
        do
        {
            url = try pagination?.queryURL(baseURL: baseURL) ?? baseURL
        }
        catch
        {
            url = baseURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let paginationResponse = try decoder.decode(PaginationResponse<Transaction>.self, from: unwrappedData)
                completionHandler(paginationResponse.objects, paginationResponse.pagination, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, nil, errors)
            }
        }
    }
    
    public func send(money: SendMoney, from account: String, twoFactorCode: String?, completionHandler: @escaping (_ transaction: Transaction?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.send(money: money, from: account, twoFactorCode: twoFactorCode, completionHandler: completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/accounts/\(account)/transactions")
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        
        // Body
        do
        {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(money)
        }
        catch
        {
            completionHandler(nil, [error])
            return
        }
        
        // Headers
        var headers = self.defaultHeaders
        if let unwrappedTwoFactorCode = twoFactorCode
        {
            headers["CB-2FA-TOKEN"] = unwrappedTwoFactorCode
        }
        
        request.allHTTPHeaderFields = headers
        
        // Send request
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(SingularResponse<Transaction>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: User

public extension CoinbaseAPIClient
{
    public func fetchCurrentUser(_ completionHandler: @escaping (_ user: User?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.fetchCurrentUser(completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/user")
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SingularResponse<User>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
    
    public func updateCurrentUser(edits: UserEdits, completionHandler: @escaping (_ user: User?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.updateCurrentUser(edits: edits, completionHandler: completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/user")
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(edits)
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SingularResponse<User>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Addresses

public extension CoinbaseAPIClient
{
    public func createAddress(accountID: String, completionHandler: @escaping (_ address: Address?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.createAddress(accountID: accountID, completionHandler: completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/accounts/\(accountID)/addresses")
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(SingularResponse<Address>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Exchange rates

public extension CoinbaseAPIClient
{
    public func fetchExchangeRates(baseCurrencyCode: String, completionHandler: @escaping (_ exchangeRate: ExchangeRate?, _ errors: [Error]?) -> Void)
    {
        // Build request
        let baseURL = self.baseURL.appendingPathComponent("/v2/exchange-rates")
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        let currencyItem = URLQueryItem(name: "currency", value: baseCurrencyCode)
        urlComponents.queryItems = [currencyItem]
        
        // Perform request
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SingularResponse<ExchangeRate>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Payment methods

public extension CoinbaseAPIClient
{
    public func fetchPaymentMethods(_ completionHandler: @escaping (_ paymentMethods: [PaymentMethod]?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.fetchPaymentMethods(completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/payment-methods")
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = self.defaultHeaders
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(PaginationResponse<PaymentMethod>.self, from: unwrappedData)
                completionHandler(response.objects, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Buy

public extension CoinbaseAPIClient
{
    public func place(buyOrder: BuySellOrder, for account: String, completionHandler: @escaping (_ buy: Buy?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.place(buyOrder: buyOrder, for: account, completionHandler: completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/accounts/\(account)/buys")
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(buyOrder)
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(SingularResponse<Buy>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}

// MARK: Sell

public extension CoinbaseAPIClient
{
    public func place(sellOrder: BuySellOrder, for account: String, completionHandler: @escaping (_ sell: Sell?, _ errors: [Error]?) -> Void)
    {
        if self.isRefreshingToken
        {
            self.queueRequest(self.place(sellOrder: sellOrder, for: account, completionHandler: completionHandler))
            return
        }
        
        let baseURL = self.baseURL.appendingPathComponent("/v2/accounts/\(account)/sells")
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = self.defaultHeaders
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(sellOrder)
        
        self.perform(request: request) { [weak self] (json, data, response, error) in
            guard let unwrappedData = data else
            {
                completionHandler(nil, nil)
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(SingularResponse<Sell>.self, from: unwrappedData)
                completionHandler(response.object, nil)
            }
            catch
            {
                let errors = self?.buildErrors(data: data)
                completionHandler(nil, errors)
            }
        }
    }
}
