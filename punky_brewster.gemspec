# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'punky_brewster/version'

Gem::Specification.new do |spec|
  spec.name          = "punky_brewster"
  spec.version       = PunkyBrewster::VERSION
  spec.authors       = ["Pete Nicholls"]
  spec.email         = ["pete@metanation.com"]

  spec.summary       = %q{What's pouring at Punky Brewster?}
  spec.homepage      = "https://github.com/Aupajo/punky_brewster"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "rack"

  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rack-test"
end
