Gem::Specification.new do |s|
  s.name        = "rainforest_auth"
  s.version     = "0.0.8"
  s.date        = "2013-08-02"
  s.summary     = "Authentication of messages for Rainforest webhooks"
  s.description = "Signs / Authenticates messages"
  s.authors     = ["Russell Smith", "Kelly Becker"]
  s.email       = ["russ@rainforestqa.com", "kellylsbkr@gmail.com"]
  s.files       = ["lib/rainforest/auth.rb"]
  s.homepage    = "https://www.rainforestqa.com/"
  s.add_dependency('json')
end
