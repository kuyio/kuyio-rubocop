# frozen_string_literal: true

require_relative "lib/kuyio/rubocop/version"

Gem::Specification.new do |spec|
  spec.name        = "kuyio-rubocop"
  spec.version     = Kuyio::Rubocop::VERSION
  spec.authors     = ["KUY.io Inc."]
  spec.email       = ["dev@kuy.io"]
  spec.summary     = "KUY.io shared rubocop configuration."
  spec.description = "Shared RuboCop configuration for KUY.io projects, with the RuboCop gems it needs as dependencies."
  spec.homepage    = "https://github.com/kuyio/kuyio-rubocop"
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.4"

  spec.metadata["allowed_push_host"]     = "https://rubygems.org"
  spec.metadata["homepage_uri"]          = spec.homepage
  spec.metadata["source_code_uri"]       = "#{spec.homepage}/tree/main"
  spec.metadata["changelog_uri"]         = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["lib/**/*", "rubocop-*.yml", "CHANGELOG.md", "LICENSE", "README.md"]

  # Define Rubocop as gem dependencies so all projects
  # importing this gem can run bundle exec rubocop out
  # of the box without having to maintain rubocop gem
  # dependencies themselves.
  spec.add_dependency "rubocop", "~> 1.92.2"
  spec.add_dependency "rubocop-performance", "~> 1.27.0"
  spec.add_dependency "rubocop-rails", "~> 2.38.0"
  spec.add_dependency "rubocop-rspec", "~> 3.10.2"
end
