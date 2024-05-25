# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8', '>= 7.0.8.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

gem 'turbolinks', '~> 5'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

gem 'webpacker', '~> 5.4', '>= 5.4.4'

gem 'sass-rails', '~> 5.0'

gem 'fast_jsonapi'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'dry-validation'

# A simple, standardized way to build and use Service Objects (aka Commands) in Ruby
gem 'simple_command'

gem 'pundit'
gem 'httparty'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'rubocop', '1.43', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'factory_bot_rails', '~> 4.11.1', require: false
  gem 'faker', '~> 2.19.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
  gem 'annotate'
end

group :test do
  gem 'selenium-webdriver'
  gem 'pundit-matchers'
  gem 'rspec-graphql_matchers'
  gem 'rspec-rails'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
