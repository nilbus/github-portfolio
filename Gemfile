source "https://rubygems.org"

ruby "2.2.2"

gem "adamantium"
gem "airbrake"
gem "autoprefixer-rails"
gem "bourbon", "~> 4.2.0"
gem "coffee-rails", "~> 4.1.0"
gem "email_validator"
gem "equalizer"
gem "flutie"
gem "haml"
gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "lift"
gem "neat", "~> 1.7.0"
gem "newrelic_rpm", ">= 3.9.8"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rack-canonical-host"
gem "puma"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "refills"
gem "sass-rails", "~> 5.0"
gem "title"
gem "uglifier"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.3.0"
end

group :test do
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
end
