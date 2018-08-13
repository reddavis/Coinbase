# Coinbase

This library is still under heavy development as it is being built alongside the macOS app [Quids](http://producthunt.com/upcoming/quids). Expect breaking changes!

## Install

```
github "reddavis/Coinbase"
```

## Usage

### Initialization

The library gives you the flexibility of how you store the oAuth credentials. You will need to implement a class that conforms to the `CoinbaseAPIClientAuthStore` protocol. `var isAuthenticated`, `var hasExpired` and `func delete()` all have default implementations, so you will only need to implement `var auth`.

The library will handle the refreshing of tokens.


```
public protocol CoinbaseAPIClientAuthStore: class
{
    var auth: CoinbaseAPIClient.Auth? { get set }
    var isAuthenticated: Bool { get }
    var hasExpired: Bool { get }
    
    func delete()
}



public extension CoinbaseAPIClientAuthStore
{
    public var isAuthenticated: Bool {
        return self.auth != nil
    }
    
    public var hasExpired: Bool {
        guard let unwrappedAuth = self.auth else
        {
            return true
        }
        
        return unwrappedAuth.expiresAt < Date()
    }
    
    public func delete()
    {
        self.auth = nil
    }
}
```


### Auth

Firstly you need to initialize the auth flow:

```
let scopes: [CoinbaseAPIClient.Scope] = [
    .readAccounts,
    .readAddresses,
    .createAddresses,
    .readTransactions,
    .readPaymentMethods,
    .readUser,
    .updateUser,
    .readUserEmailAddress
]

let url = self.coinbaseAPIClient.authorizeURL(scopes: scopes)
NSWorkspace.shared.open(url)
```

Then you need to get the oAuth token:

```
let redirectURL = URL(string: "quids://coinbase/auth")!

self.coinbaseAPIClient.authenticate(code: code, redirectURL: redirectURL) { (success, error) in
    self.authCompletionHandler?(success, error)
}
```

### Requests

Only a few requests are currently supported, more will be added as we add features to [Quids](http://producthunt.com/upcoming/quids).

```
public func fetchAccounts(_ completionHandler: @escaping (_ accounts: [Account]?, _ errors: [Error]?) -> Void)
public func fetchTransactions(accountID: String, completionHandler: @escaping (_ transactions: [Transaction]?, _ errors: [Error]?) -> Void)
public func fetchCurrentUser(_ completionHandler: @escaping (_ user: User?, _ errors: [Error]?) -> Void)
public func updateCurrentUser(edits: UserEdits, completionHandler: @escaping (_ user: User?, _ errors: [Error]?) -> Void)
public func createAddress(accountID: String, completionHandler: @escaping (_ address: Address?, _ errors: [Error]?) -> Void)
public func fetchExchangeRates(baseCurrencyCode: String, completionHandler: @escaping (_ exchangeRate: ExchangeRate?, _ errors: [Error]?) -> Void)
public func fetchPaymentMethods(_ completionHandler: @escaping (_ paymentMethods: [PaymentMethod]?, _ errors: [Error]?) -> Void)
public func place(buyOrder: BuySellOrder, for account: String, completionHandler: @escaping (_ buy: Buy?, _ errors: [Error]?) -> Void)
public func place(sellOrder: BuySellOrder, for account: String, completionHandler: @escaping (_ sell: Sell?, _ errors: [Error]?) -> Void)
```

## License

[MIT License](http://www.opensource.org/licenses/MIT).
