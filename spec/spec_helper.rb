require 'simplecov'
require 'rspec'

ENV["RACK_ENV"] ||= 'test'

require_relative '../lib/rainforest_auth'

# Configure rspec
RSpec.configure do |config|
  config.mock_with :rspec
  config.fail_fast = true
end
