[![Gem Version](https://badge.fury.io/rb/rainforest_auth.png)](http://badge.fury.io/rb/rainforest_auth)
[![Build Status](https://travis-ci.org/rainforestapp/auth.png?branch=master)](https://travis-ci.org/rainforestapp/auth)

# Rainforest Auth

Allows verification of [Rainforest](https://www.rainforestqa.com/) webhook messages using your private API key.

## Installation

Rainforest Auth is available as a gem, to install it just install the gem:

    gem install rainforest_auth

If you're using Bundler, add the gem to Gemfile.

    gem 'rainforest_auth'

Then run bundle install.

## Where can I find my API key?

You can find your API key for Rainforest under the [Accounts setting page](https://app.rainforestqa.com/settings/account). If you get stuck finding this, please [reach out](mailto:5h9w4xa0@incoming.intercom.io)!

## Examples

The following example recieves a 'before_run' notification from Rainforest, authenticates it, does a task for you and then notifies Rainforest to continue.

```ruby
require "rainforest/auth"
require "httparty"

class RainforestCallbacksController < ApplicationController
  def create
    # Check the callback is valid
    rainforest_auther.run_if_valid(params[:digest], params[:callback_type], params[:options]) do

        # Work out what to do
        case params[:callback_type]
            when 'before_run'
                # Reset the database?
            when 'after_run'
                # Trigger deploy!
        end

        # Get the callback url for this run
        callback_url = rainforest_auther.get_run_callback(params[:options]['run_id'], params[:callback_type])

        # Notify Rainforest you are ready for a run to start
        HTTParty.post callback_url
    end
  end

private
  def rainforest_auther
    @rainforest_auther ||=  RainforestAuth.new 'YOUR_KEY_HERE'
  end
end
```

Checking if the signature is valid;

```ruby
require "rainforest/auth"

r_auth = RainforestAuth.new('YOUR_KEY_HERE')

# Check the digest is correct
if r_auth.verify digest, callback_type, options
    puts "The digest was valid."
else
    puts "The digest was invalid!"
end
```

Running a block if the signature is valid;

```ruby
require "rainforest/auth"

r_auth = RainforestAuth.new('YOUR_KEY_HERE')

# Run a block if it works
r_auth.run_if_valid(digest, callback_type, options) {
    puts "The digest was valid."
}
```

## License
MIT License. See [LICENSE](/rainforestapp/auth/blob/master/LICENSE) for details.

## Copyright
Copyright (c) 2014 CLDRDR, Inc.
