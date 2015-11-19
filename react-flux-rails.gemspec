# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'react/flux/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "react-flux-rails"
  spec.version       = React::Flux::Rails::VERSION
  spec.authors       = ["Bunlong"]
  spec.email         = ["bunlong.van@gmail.com"]

  spec.summary       = %q{react-flux-rails is a simple flux pattern javascript Gem for using in Rails framework.}
  spec.description   = %q{react-flux-rails is a simple flux pattern javascript Gem for using in Rails framework.}
  spec.homepage      = "https://github.com/Bunlong/react-flux-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
