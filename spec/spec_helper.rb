require 'simplecov'
SimpleCov.start

require 'rspec'

ENV["RACK_ENV"] ||= 'test'

require_relative '../lib/rainforest/auth'

# Configure rspec
RSpec.configure do |config|
  config.mock_with :rspec
  config.fail_fast = true
end
