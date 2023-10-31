source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.8"

gem "pg", "~> 1.1"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"

gem "turbo-rails", github: "hotwired/turbo-rails", branch: "main"
gem "strada-rails", "~> 0.0.1"
gem "stimulus-rails"

gem 'sassc-rails'
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "devise", "~> 4.9"
gem "activeadmin"
gem "tailwindcss-rails", "~> 2.0"
gem 'metainspector'