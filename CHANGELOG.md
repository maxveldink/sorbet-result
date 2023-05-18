# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
