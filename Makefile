# Standard Makefile for library gems.
GEM_NAME := kuyio-rubocop
VERSION = $(shell ruby -e 'puts Gem::Specification.load("$(GEM_NAME).gemspec").version')

# Supported Rubies: the previous release and the current one.
RUBIES ?= 3.4.8 4.0.9

.PHONY: all test lint spec trivy audit test-rubies build clean release-check release install

all: test

test: lint spec trivy audit

lint:
	@echo "Running lint tests with Rubocop ..."
	bundle exec rubocop

spec:
	@echo "Running testsuite with Minitest ..."
	bundle exec rake test

trivy:
	@echo "Running vulnerability tests with Trivy ..."
	trivy fs --config trivy.yaml --severity UNKNOWN,LOW --exit-code 0 .
	trivy fs --config trivy.yaml .

audit:
	@echo "Checking Ruby dependencies with bundle-audit ..."
	bundle exec bundle-audit check --update

# Requires rbenv. Fails if RBENV_VERSION does not select the expected Ruby.
test-rubies:
	@for v in $(RUBIES); do \
		echo "==> Ruby $$v"; \
		actual=$$(RBENV_VERSION=$$v ruby -e 'print RUBY_VERSION'); \
		if [ "$$actual" != "$$v" ]; then \
			echo "Expected Ruby $$v but got '$$actual'. Is rbenv active?" >&2; \
			exit 1; \
		fi; \
		RBENV_VERSION=$$v bundle install --quiet && RBENV_VERSION=$$v $(MAKE) --no-print-directory spec || exit 1; \
	done

build: clean
	gem build $(GEM_NAME).gemspec

clean:
	rm -f $(GEM_NAME)-*.gem

# Only release a clean tree from a pushed commit, and never a version that is
# already tagged.
release-check:
	@test -z "$$(git status --porcelain)" || \
		{ echo "Working tree must be clean to release" >&2; exit 1; }
	@git merge-base --is-ancestor HEAD origin/main || \
		{ echo "HEAD must be pushed to origin/main to release" >&2; exit 1; }
	@test -z "$$(git tag --list v$(VERSION); git ls-remote --tags origin v$(VERSION))" || \
		{ echo "v$(VERSION) is already tagged" >&2; exit 1; }

# Projects install this gem from GitHub, so the tag is the release.
release: release-check test
	git tag -a v$(VERSION) -m "v$(VERSION)"
	git push origin v$(VERSION)

install: build
	gem install --local $(GEM_NAME)-*.gem
