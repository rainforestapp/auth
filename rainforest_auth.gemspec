Gem::Specification.new do |s|
  s.name        = "rainforest_auth"
  s.version     = "0.0.8"
  s.date        = "2013-08-07"
  s.summary     = "Authentication of messages for Rainforest webhooks"
  s.description = "Signs / Authenticates messages"
  s.authors     = ["Russell Smith"]
  s.email       = "russ@rainforestqa.com"
  s.files       = ["lib/rainforest/auth.rb"]
  s.homepage    = "https://www.rainforestqa.com/"

  # signing key and certificate chain
  s.signing_key = "/Users/russ/.ssh/gem-private_key.pem" unless ENV['CODESHIP']
  s.cert_chain  = ['gem-public_cert.pem']

  s.add_dependency('json')
end
