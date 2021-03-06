require_relative 'lib/whats_happening/version'

Gem::Specification.new do |spec|
  spec.name          = "whats_happening"
  spec.version       = WhatsHappening::VERSION
  spec.authors       = ["meggs1"]
  spec.email         = ["megan.schertz@gmail.com"]
  spec.summary       = %q{Learn whats happening any month of the year!}
  # spec.description   = %q{ Write a longer description or delete this line.}

  spec.homepage      = "https://github.com/meggs1/whats_happening"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = " Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/meggs1/whats_happening"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundle"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"
end
