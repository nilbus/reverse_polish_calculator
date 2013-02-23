# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reverse_polish_calculator/version'

Gem::Specification.new do |gem|
  gem.name          = "reverse_polish_calculator"
  gem.version       = ReversePolishCalculator::VERSION
  gem.authors       = ["Edward Anderson"]
  gem.email         = ["nilbus@nilbus.com"]
  gem.description   = %q{Reverse Polish Notation calculator}
  gem.summary       = %q{Do math in RPN using the command line tool rpn or in Ruby}
  gem.homepage      = "https://github.com/nilbus/reverse_polish_calculator"
  gem.license       = "MIT, Copyright (c) 2013 Edward Anderson"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
end
