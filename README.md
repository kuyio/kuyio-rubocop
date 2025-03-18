# kuyio-rubocop

KUY.io shared rubocop configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test, :development do
  gem 'kuyio-rubocop', github: 'kuyio/kuyio-rubocop'
end
```

And then run:

```bash
$ bundle install
```

## Usage

Create a `.rubocop.yml` with the following directives:

```yaml
inherit_gem:
  kuyio-rubocop:
    - rubocop-default.yml
```

Now, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. This gem will include a specific version of `rubocop` and `rubocop-rspec` that is shared across all projects.
