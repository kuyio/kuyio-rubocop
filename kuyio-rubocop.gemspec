# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kuyio/rubocop/version"

Gem::Specification.new do |spec|
  spec.name          = "kuyio-rubocop"
  spec.version       = Kuyio::Rubocop::VERSION
  spec.authors       = ["KUY.io Inc."]
  spec.email         = ["dev@kuy.io"]

  spec.summary       = 'KUY.io shared rubocop configuration.'
  spec.homepage      = 'https://github.com/kuyio/kuyio-rubocop'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Define Rubocop as gem dependencies so all projects
  # importing this gem can run bundle exec rubocop out
  # of the box without having to maintain rubocop gem
  # dependencies themselves.
  spec.add_dependency "rubocop", "~> 1.4"
  spec.add_dependency "rubocop-rspec", "~> 2.19"
  spec.add_dependency "rubocop-rails", "~> 2.18"
  spec.add_dependency "rubocop-performance", "~> 1.16"
  spec.add_dependency "brakeman", "~> 5.4"
  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13.0"
end
