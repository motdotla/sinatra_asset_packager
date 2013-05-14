require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'sinatra_asset_packager'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
end