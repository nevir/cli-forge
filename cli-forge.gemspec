# -*- encoding: utf-8 -*-

require File.expand_path("../lib/cli_forge/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "cli-forge"
  gem.version     = CLIForge::VERSION
  gem.homepage    = "https://github.com/nevir/cli-forge"
  gem.summary     = "Beat your CLI tool suites into submission!"
  gem.description = "A library for building CLI tools that are intended to be easily extensible (git style)"
  gem.author      = "Ian MacLeod"
  gem.email       = "ian@nevir.net"

  gem.platform = Gem::Platform::RUBY

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
end
