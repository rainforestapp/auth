[![Build Status](https://travis-ci.org/rainforestapp/auth.png?branch=master)](https://travis-ci.org/rainforestapp/auth)

# Rainforest Auth

Allows verification of Rainforest webhook messages using your private API key.

## Installation

Rainforest Auth is available as a gem, to install it just install the gem:

    gem install rainforest_auth

If you're using Bundler, add the gem to Gemfile.

    gem 'rainforest_auth'

Then run bundle install.

## Examples

Receive a notice that a run is starting and notify Rainforest when you are ready for a run to start

```ruby
require "rainforest/auth"
require "httparty"

class CallbackController < ApplicationController

  def new
    # Replace test with your key
    @r_auth = RainforestAuth.new 'test'
  end

  def callback
    # Check the callback is valid
    @r_auth.run_if_valid(params[:digest], params[:action], params[:options]) do

        # Work out what to do
        case params[:action]
            when 'before_run'
                # Reset the database?
            when 'after_run'
                # Trigger deploy!
        end

        # Get the callback url for this run
        callback_url = @r_auth.get_run_callback(run_id, params[:action])

        # Notify Rainforest you are ready for a run to start
        HTTParty.get @url
    end

  end

end
```

Checking if the signature is valid;

```ruby
require "rainforest/auth"

# Replace test with your key
r_auth = RainforestAuth.new 'test'

# Check the digest is correct
if r_auth.verify digest, command, options
    puts "The digest was valid."
else
    puts "The digest was invalid!"
end
```

Running a block if the signature is valid;

```ruby
require "rainforest/auth"

# Replace test with your key
r_auth = RainforestAuth.new 'test'

# Run a block if it works
r_auth.run_if_valid(digest, command, options) {
    puts "The digest was valid."
}
```

## License
MIT License. See [LICENSE](/rainforestapp/auth/blob/master/LICENSE) for details.

## Copyright
Copyright (c) 2013 CLDRDR, Inc.
