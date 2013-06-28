require 'rspec'

ENV["RACK_ENV"] ||= 'test'

require File.expand_path('../lib/rainforest/auth', File.dirname(__FILE__))

# Configure rspec
RSpec.configure do |config|
  config.mock_with :rspec
end