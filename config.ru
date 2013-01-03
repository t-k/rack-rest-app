ENV['RACK_ENV'] ||= "development"
require 'rubygems'
require 'bundler'

Bundler.require

require "./config/boot"

run PostsControllers.new