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

  def get_run_callback run_id, callback_type
    digest = sign(callback_type, {:run_id => run_id})
    "https://app.rainforestqa.com/api/1/callback/run/#{run_id}/#{callback_type}/#{digest}"
  end

  # Return a signature for a callback_type and specified options
  def sign callback_type, options = nil
    OpenSSL::HMAC.hexdigest(digest, @key, merge_data(callback_type, options))
  end

  # Verify a digest vs callback_type and options
  def verify digest, callback_type, options = nil
    digest == sign(callback_type, options)
  end

  # Run a block if valid
  def run_if_valid digest, callback_type, options, &block
    if verify digest, callback_type, options
      block.call callback_type, options
    end
  end

  private

  def digest
    OpenSSL::Digest::Digest.new 'sha1'
  end

  def merge_data callback_type, options
    {:callback_type => callback_type, :options => options}.to_json
  end
end
