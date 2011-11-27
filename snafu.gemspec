# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "snafu/version"

Gem::Specification.new do |s|
  s.name        = "snafu"
  s.version     = Snafu::VERSION
  s.authors     = ["Jeff Browning"]
  s.email       = ["jeff@jkbrowning.com"]
  s.homepage    = "http://jbrowning.org"
  s.summary     = %q{A Ruby library for the Glitch API}
  s.description = %q{This gem provides a convenient way to consume the Glitch 
                  API located at http://api.glitch.com}

  s.rubyforge_project = "snafu"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'httparty'
end
