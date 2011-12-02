# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "snafu/version"

Gem::Specification.new do |s|
  s.name        = "snafu"
  s.version     = Snafu::VERSION
  s.authors     = ["Jeff Browning"]
  s.license     = 'MIT'
  s.email       = ["jeff@jkbrowning.com"]
  s.homepage    = "https://github.com/jbrowning/snafu"
  s.summary     = %q{A library for the Glitch API}
  s.description = %q{Snafu is an interface to the Glitch API. Glitch is an online 
  multi-player game created by Tiny Speck.}

  s.required_ruby_version = '>= 1.9.2'

  s.rubyforge_project = "snafu"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'httparty', '~> 0.8'
end
