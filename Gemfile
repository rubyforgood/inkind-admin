source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem "bootsnap", ">= 1.4.4", require: false
gem "devise"
gem "devise-security", "~> 0.16.0"
gem "faker", "~> 2.17"
gem "graphiql-rails", "1.8.0"
gem "graphql", "~> 1.12"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails"
gem "redis", "~> 4.5"
gem "sass-rails", "~> 6.0"
gem "stimulus_reflex", "~> 3.4"
gem "turbolinks", "~> 5.2.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "webpacker", "~> 5.4"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "pry-byebug"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
  gem "foreman"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "factory_bot_rails", "~> 6.2"
  gem "rspec-rails", "~> 5.0.0"
  gem "standardrb"
  gem "selenium-webdriver", "4.0.0.rc2" # temporarily locking to a beta version until 4.x comes out - to fix docker tests https://github.com/SeleniumHQ/selenium/issues/9001
  gem "shoulda-matchers"
end
