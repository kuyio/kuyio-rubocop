## [Unreleased]

### Changed

- `make release` now tags the version and pushes the tag, and no longer publishes to rubygems.org.

### Removed

- `rake release`, so that `make release` is the only release path.

## [0.6.0] - 2026-11-04

### Changed

- Require Ruby 3.4 or newer.
- Package only the configuration files, `lib`, the README, the license and this changelog.
- Move development dependencies from the gemspec to the `Gemfile`.

### Removed

- `rubocop-shopify.yml`. Any project that inherits it must remove that line from its `.rubocop.yml`.

Earlier versions have no changelog entries. See the git tags and history.
