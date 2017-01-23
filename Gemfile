source 'https://rubygems.org'

# Declare your gem's dependencies in shiftcommerce.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# Shift Commerce gem
gem "flex_commerce_api", git: "https://github.com/flex-commerce/flex-ruby-gem.git", tag: 'v0.6.25'

group :development, :test do
  # Debugging tools
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  # Mocks
  gem "webmock", "~> 1.24.2", require: false

  # Feature tests (not yet used)
  # gem "capybara", "~> 2.7"
  # gem "capybara-webkit", "~> 1.7"
end
