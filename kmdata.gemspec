# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kmdata/version'

Gem::Specification.new do |spec|
  spec.name          = "kmdata"
  spec.version       = KMData::VERSION
  spec.authors       = ["Kyle Decot"]
  spec.email         = ["decot.7@osu.edu"]
  spec.description   = %q{A simple API wrapper for interacting with the KMData Project}
  spec.summary       = %q{A simple API wrapper for interacting with the KMData Project}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "recursive-open-struct"
end
