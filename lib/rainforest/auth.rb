#
# Rainforest Authenitcation
#
#
# @author Russell Smith <russ@rainforestqa.com>
# @copyright CLDRDR Inc, 2013

require 'openssl'
require 'json'

class RainforestAuth

  attr_reader :key

  def initialize key
    @key = key
    self
  end

  # Return a signature for a command and specified options
  def sign command, options
    OpenSSL::HMAC.hexdigest(digest, @key, merge_data(command, options))
  end

  # Verify a digest vs command and options
  def verify digest, command, options
    digest == sign(command, options)
  end

  # Run a block if valid
  def run_if_valid digest, command, options, &block
    if verify digest, command, options
      block.call command, options
    end
  end

  private

  def digest
    OpenSSL::Digest::Digest.new 'sha1'
  end

  def merge_data command, options
    {command: command, options: options}.to_json
  end

end