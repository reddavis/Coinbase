# Changelog

## [1.2] - 18/12/2018

### Added

- `AuthInformation` object.
- `AuthMetadata` object.
- Fetch a users `AuthInformation` API call.

### Changed

- `Scope` is now equatable.
- `Scope` is now decodable.
- `Auth` now has array of `Scope` objects rather than an array of `String`'s.

## [1.1] - 12/12/2018

### Added

- Use of a [token swap service](https://github.com/reddavis/Coinbase-Token-Swap) for authorization.

### Removed

- Initializing `CoinbaseAPIClient` with a secret key.
