# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'obtuse/version'

Gem::Specification.new do |gem|
  gem.name          = "obtuse"
  gem.version       = Obtuse::VERSION
  gem.authors       = ["Utkarsh Kukreti"]
  gem.email         = ["utkarshkukreti@gmail.com"]
  gem.description   = "A Stack-oriented programming language, optimized for " +
                      "brevity."
  gem.summary       = "A Stack-oriented programming language, optimized for " +
                      "brevity."
  gem.homepage      = "https://github.com/utkarshkukreti/obtuse"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "parslet"

  %w{rspec guard-rspec simplecov pry}.each do |name|
    gem.add_development_dependency name
  end
end
