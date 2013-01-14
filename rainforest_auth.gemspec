Gem::Specification.new do |s|
  s.name        = "rainforest_auth"
  s.version     = "0.0.4"
  s.date        = "2013-01-14"
  s.summary     = "Authentication of messages for Rainforest webhooks"
  s.description = "Signs / Authenticates messages"
  s.authors     = ["Russell Smith"]
  s.email       = "russ@rainforestqa.com"
  s.files       = ["lib/rainforest/auth.rb"]
  s.homepage    = "https://www.rainforestqa.com/"

  # signing key and certificate chain
  #s.signing_key = "/Users/russ/.ssh/gem-private_key.pem"
  #s.cert_chain  = ['gem-public_cert.pem']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'bundler'
end
