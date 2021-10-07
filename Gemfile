# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'faker', '~> 2.17'
gem 'graphiql-rails', '1.8.0'
gem 'graphql', '~> 1.12'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '6.1.3.2'
gem 'sass-rails', '~> 6.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'standardrb'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
