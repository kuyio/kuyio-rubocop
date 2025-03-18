# Makefile for kuyio-rubocop
#
# This Makefile is used to automate the build, test, release, and deployment process for the kuyio-rubocop gem.
# It includes targets for building the gem, running tests, releasing the gem on GitHub, deploying it to rubygems.org, and cleaning up generated files.
#
# The Makefile uses the `@` symbol to suppress command output, and it provides informative messages for each target.
#
# The `all` target is the default target that runs when no target is specified. It runs the `test` target.
#
# The `build` target builds the gem from the gemspec file. The `test` target runs rubocop to check for code style issues.
#
# The `release` target runs a script to release the gem on GitHub. The `deploy` target runs a script to deploy the gem to rubygems.org.
#
# The `install` target installs the gem locally after building it. The `clean` target removes any generated gem files.
#
.PHONY: build test release deploy install clean

all: test

build:
	@echo "Building kuyio-rubocop..."
	@gem build kuyio-rubocop.gemspec

test:
	@echo "Running tests..."
	@bundle exec rubocop -c .rubocop.yml

release:
	@echo "Releasing kuyio-rubocop on GitHub..."
	@./bin/release

deploy:
	@echo "Deploying kuyio-rubocop to rubygems.org..."
	@./bin/deploy

install: test build
	@echo "Installing kuyio-rubocop..."
	@gem install --local kuyio-rubocop-*.gem

clean:
	@echo "Cleaning up..."
	@rm -f kuyio-rubocop-*.gem