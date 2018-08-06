
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "uls_db/version"

Gem::Specification.new do |spec|
  spec.name          = "uls_db"
  spec.version       = UlsDb::VERSION
  spec.authors       = ["dbwinger"]
  spec.email         = ["dbwinger@gmail.com"]

  spec.summary       = %q{Utilities for extracting data from FCC's ULS Databases}
  spec.homepage      = "https://github.com/dbwinger/uls_db"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end