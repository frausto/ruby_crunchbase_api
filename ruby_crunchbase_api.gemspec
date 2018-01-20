# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crunchbase/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_crunchbase_api'
  spec.version       = Crunchbase::VERSION
  spec.authors       = ['Nolan Frausto']
  spec.email         = ['nolan@warmintro.ai']
  spec.summary       = 'A Ruby wrapper for Crunchbase API v3.1'
  spec.description   = 'A Ruby wrapper for Crunchbase API version 3.1'
  spec.homepage      = 'https://github.com/frausto/ruby_crunchbase_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'oj'

  spec.add_dependency 'rest-client'
  spec.add_dependency 'hashie'
end