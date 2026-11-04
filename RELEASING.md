# Releasing

Projects install this gem from GitHub, so pushing a version tag is the release.

1. Update the version in `lib/kuyio/rubocop/version.rb`.
1. Add the version to `CHANGELOG.md`, and note anything projects must change.
1. Run `make test`.
1. Commit the changes.
1. Tag the release and push it:

```bash
git tag vX.Y.Z
git push origin main vX.Y.Z
```

Projects pick up the new version when they run `bundle update kuyio-rubocop`.

`make release` also publishes to rubygems.org, which isn't part of this process.
