# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "logbook/cli"

Gem::Specification.new do |spec|
  spec.name          = "logbook-cli"
  spec.version       = Logbook::CLI::VERSION
  spec.authors       = ["Gabriel Malkas"]
  spec.email         = ["gabriel.malkas@gmail.com"]

  spec.summary       = %q{CLI for handling logbooks.}
  spec.description   = %q{CLI for handling logbooks.}
  spec.homepage      = "https://www.logbook.sh"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"

  spec.add_runtime_dependency "logbook-ruby", "~> 0.1"
end
