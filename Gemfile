source 'http://rubygems.org'

gem 'rack'
gem 'mysql2'
gem 'activerecord', require: 'active_record'
gem 'yajl-ruby', require: 'yajl'
gem 'thin', require: false

group :development, :test do
  gem 'rspec'
  gem 'libnotify'
  gem 'rb-inotify'
  gem 'racksh'
end

group :development do
  gem 'foreman'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
end

group :test do
  gem 'factory_girl'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork', platforms: :ruby
end