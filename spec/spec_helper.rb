ENV['RACK_ENV'] = 'test'
require 'rubygems'
require 'bundler'

require 'rspec'
require 'rack/test'
require 'spork'

require './config/boot.rb'

Spork.prefork do
  require 'factory_girl'
  FactoryGirl.find_definitions

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
  end
end