source "https://rubygems.org"

ruby "2.2.3"

gem "adamantium"
gem "airbrake"
gem "autoprefixer-rails"
gem "bourbon", "~> 4.2.0"
gem "coffee-rails", "~> 4.1.0"
gem "email_validator"
gem "equalizer"
gem "faraday-http-cache"
gem "flutie"
gem "haml"
gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "lift"
gem "masonry-rails"
gem "neat", "~> 1.7.0"
gem "newrelic_rpm", ">= 3.9.8"
gem "normalize-rails", "~> 3.0.0"
gem "octokit"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "refills"
gem "sass-rails", "~> 5.0"
gem "sqlite3"
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
  gem "pry-byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "guard-shell"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.3.0"
end

group :test do
  gem "database_cleaner"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
  gem "vcr"
  gem "webmock"
end

group :staging, :production do
  gem "dalli"
end
