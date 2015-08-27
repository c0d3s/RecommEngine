$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = 'RecommEngine'
  s.version       = '0.1.0'
  s.date          = '2015-08-26'
  s.summary       = "A flexible recommendation engine."
  s.description   = "A flexible recommendation engine supporting multiple similarity algorithms for use in ecommerce sites, marketplaces, social sharing apps, and more."
  s.authors       = ["Cody Knauer"]
  s.email         = 'codyknauer@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.homepage      = 'http://github.com/c0d3s/RecommEngine'
  s.license       = 'MIT'
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.1'
end