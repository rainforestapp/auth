Gem::Specification.new do |s|
  s.name          = "rainforest_auth"
  s.version       = "0.0.12"
  s.date          = "2017-03-01"
  s.summary       = "Authentication of messages for Rainforest webhooks"
  s.description   = "Signs / Authenticates messages"
  s.authors       = ["Russell Smith"]
  s.email         = ["russ@rainforestqa.com"]
  s.files         = ["lib/rainforest/auth.rb"]
  s.homepage      = "https://www.rainforestqa.com/"
  s.require_paths = ["lib"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.add_dependency('json')
end
