# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2025-06-29

### Added

- Added error details to `Typed::NoPayloadOnFailureError` error message

## [1.2.0] - 2024-11-03

### Added

- Add `Typed::Success(payload)` and `Typed::Failure(error)` convenience method (no more `.new`-ing!)
- Add `Typed::Success#==` and `Typed::Failure#==` implementations

### Removed

- **POTENTIALLY BREAKING** Remove support for Ruby < 3.1.

## [1.1.0] - 2024-02-21

### Added

- Add minitest assertions for Results

### Changed

- Switched to Standard over using Rubocop directly

## [1.0.0] - 2023-06-20

### Removed

- Remove support for Ruby < 3.0

## [0.3.1] - 2023-06-20

### Added

- Add `#on_error` to `Typed::Result` to allow behavior when an error is encountered during chaining.
- Add `#payload_or` to `Typed::Result` to allow callers to specify a default value if `Failure` is returned.

## [0.3.0] - 2023-06-06

### Added

- Add `.blank` to create a `Typed::Success` with a `nil` payload or a `Typed::Failure` with a `nil` error.
- Add `#and_then` to `Typed::Result` to allow chaining of results. See #14 for more details.

### Changed

- *Breaking* Make `Typed::Success#Error` and `Typed::Failure#Payload` fixed to `T.noreturn`. This allows to specify the other type_member only when using generics. See #8 for more details
- *Breaking* Remove `T.nilable` from `Payload` and `Error` parameters in `Typed::Success.new` and `Typed::Failure.new`. Nilability will now need to be specified in the generic type. This also means that you'll need to use the new `.blank` instead of `.new` when you want to create a `Typed::Success` or `Typed::Failure` with a `nil` payload or error.
- *Breaking* Change `Typed::Success` and `Typed::Failure` initialize arguments from keyword to positional.
- Improve `Typed::Success.new` and `Typed::Failure.new` to make them generic methods and automatically infer the type of the `payload` and `error` arguments. See #8 for more details

## [0.2.1] - 2023-05-18

### Added

- Automated gem release process

### Changed

- Update dependencies

## [0.2.0] - 2023-04-21

### Changed

- *Breaking* Updated all `T::` modules to `Typed::`. This allows the Sorbet project freedom to explore these constants in the future.
- Pulled in Zeitwerk for autoloading.

## [0.1.1] - 2023-04-17

### Changed

- Updated `T::Result` to be an abstract class, instead of an interface module.

### Fixed

- `bin/console` now requires the correct file.

## [0.1.0] - 2023-04-17

### Added

- `T::Result`, `T::Success` and `T::Failure` types.
- Basic documentation.
