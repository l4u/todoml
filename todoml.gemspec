# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todoml/version'

Gem::Specification.new do |spec|
  spec.name          = "todoml"
  spec.version       = Todoml::VERSION
  spec.authors       = ["Leo Lou"]
  spec.email         = ["louyuhong@gmail.com"]
  spec.description   = "Manage tasks stored in YAML, grouping by velocity."
  spec.summary       = "Todoml is a helper for managing tasks stored in" \
    "plain text file, specifically in YAML. Originally the goal of this gem" \
    "is to manage todo lists stored in TOML, or INI files."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
end
