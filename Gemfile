source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem 'devise', '~> 4.9', '>= 4.9.2'
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'byebug', '~> 11.1', '>= 11.1.3'
end

group :development do
  gem "web-console"
end
