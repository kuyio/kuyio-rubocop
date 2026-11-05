# Releasing

Projects install this gem from GitHub, so pushing a version tag is the release.

1. Update the version in `lib/kuyio/rubocop/version.rb`.
1. Add the version to `CHANGELOG.md`, and note anything projects must change.
1. Commit the changes and push them.
1. Run `make release`. It checks for a clean, pushed and untagged commit, runs `make test`, then tags the version and pushes the tag.

Projects pick up the new version when they run `bundle update kuyio-rubocop`.
