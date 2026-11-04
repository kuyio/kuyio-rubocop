# frozen_string_literal: true

require "minitest/autorun"
require "erb"
require "yaml"
require "rubocop"
require "rubocop-performance"
require "rubocop-rails"
require "rubocop-rspec"

# Checks that the shared config loads and only names cops that exist, since a
# renamed or removed cop would otherwise surface in every repo that inherits it.
class ConfigTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  COP_NAME = %r{\A[A-Z]\w*(/[A-Z]\w*)+\z}

  def test_default_config_loads
    config = RuboCop::ConfigLoader.load_file(File.join(ROOT, "rubocop-default.yml"))

    assert_equal 3.4, config.for_all_cops["TargetRubyVersion"]
  end

  def test_every_listed_cop_exists
    known = RuboCop::Cop::Registry.global.map(&:cop_name)
    unknown = Dir[File.join(ROOT, "rubocop-*.yml")].flat_map do |file|
      # rubocop-shopify.yml is an ERB template, like any RuboCop config can be.
      names = YAML.safe_load(ERB.new(File.read(file)).result, aliases: true).keys.grep(COP_NAME)
      (names - known).map { |name| "#{File.basename(file)}: #{name}" }
    end

    assert_empty unknown
  end
end
