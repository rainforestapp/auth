[![Build Status](https://travis-ci.org/rainforestapp/auth.png?branch=master)](https://travis-ci.org/rainforestapp/auth)

# Rainforest Auth

Allows verification of Rainforest webhook messages using your private API key.

## Installation

Rainforest Auth is available as a gem, to install it just install the gem:

    gem install rainforest_auth

If you're using Bundler, add the gem to Gemfile.

    gem 'rainforest_auth'

Then run bundle install.

## Example

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
