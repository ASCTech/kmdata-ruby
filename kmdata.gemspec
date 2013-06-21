# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kmdata/version'

Gem::Specification.new do |spec|
  spec.name          = "kmdata"
  spec.version       = KMData::VERSION
  spec.authors       = ["Kyle Decot"]
  spec.email         = ["kyle.decot@me.com"]
  spec.description   = %q{wrapper for KMData API}
  spec.summary       = %q{Wrapper forthe KMData API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "json"
  # spec.add_runtime_dependency "net/http"
  # spec.add_runtime_dependency "ostruct"

end
