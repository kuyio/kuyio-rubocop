# Standard Makefile for library gems.
GEM_NAME := kuyio-rubocop

# Supported Rubies: the previous release and the current one.
RUBIES ?= 3.4.8 4.0.9

.PHONY: all test lint spec trivy audit test-rubies build clean release install

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
	trivy fs --config trivy.yaml .

audit:
	@echo "Checking Ruby dependencies with bundle-audit ..."
	bundle exec bundle-audit check --update

test-rubies:
	@for v in $(RUBIES); do \
		echo "==> Ruby $$v"; \
		RBENV_VERSION=$$v bundle install --quiet && RBENV_VERSION=$$v $(MAKE) --no-print-directory spec || exit 1; \
	done

build: clean
	gem build $(GEM_NAME).gemspec

clean:
	rm -f $(GEM_NAME)-*.gem

release: test build
	gem push $(GEM_NAME)-*.gem

install: build
	gem install --local $(GEM_NAME)-*.gem
