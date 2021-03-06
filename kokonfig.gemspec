require_relative 'lib/kokonfig/version'

Gem::Specification.new do |spec|
  spec.name          = "kokonfig"
  spec.version       = Kokonfig::VERSION
  spec.authors       = ["Elcio Nakashima"]
  spec.email         = ["elciok@gmail.com"]

  spec.summary       = %q{Kokonfig is a command line utility that generates multiple versions of files based on ERB templates and data YAML files.}
  spec.description   = <<~DESCRIPTION
    Kokonfig is a command line utility that generates multiple versions of files based on ERB templates and data YAML files.

    Kokonfig can be used to generate config files for each environment in your application, when each config mostly contains the same structure but values depend on the environment. It can also be useful when config files contain several repeated values.
  DESCRIPTION
  spec.homepage      = "https://github.com/elciok/kokonfig"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elciok/kokonfig"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.add_dependency "erb", "~> 2.2"
  # spec.add_dependency "fileutils", "~> 1.4"
  # spec.add_dependency "ostruct", "~> 0.3"
  # spec.add_dependency "pathname", "~> 0.1"
  # spec.add_dependency "yaml", "~> 0.1"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
