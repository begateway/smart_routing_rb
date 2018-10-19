lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smart_routing/version"

Gem::Specification.new do |spec|
  spec.name          = "smart_routing"
  spec.version       = SmartRouting::VERSION
  spec.authors       = ["Mikhail Davidovich"]
  spec.email         = ["mihaildv@gmail.com"]

  spec.summary       = %q{Ruby client for SmartRouting system}
  spec.description   = %q{Ruby client for SmartRouting system}
  spec.homepage      = "https://www.begateway.com/solutions/smart_routing/"
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
  spec.add_development_dependency "webmock", "~> 3.4.2"
  spec.add_development_dependency "faraday", "~> 0.15.3"
  spec.add_development_dependency "faraday_middleware", "~> 0.12.2"
  spec.add_development_dependency "byebug"
end
