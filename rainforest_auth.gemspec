Gem::Specification.new do |s|
  s.name        = "rainforest_auth"
  s.version     = "0.0.9"
  s.date        = "2014-02-13"
  s.summary     = "Authentication of messages for Rainforest webhooks"
  s.description = "Signs / Authenticates messages"
  s.authors     = ["Russell Smith"]
  s.email       = ["russ@rainforestqa.com"]
  s.files       = ["lib/rainforest/auth.rb"]
  s.homepage    = "https://www.rainforestqa.com/"
  s.add_dependency('json')
end
