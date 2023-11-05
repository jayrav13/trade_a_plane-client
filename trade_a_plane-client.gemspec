# frozen_string_literal: true

require_relative "lib/trade_a_plane/client/utilities/version"

Gem::Specification.new do |spec|
  spec.name = "trade_a_plane-client"
  spec.version = TradeAPlane::Client::VERSION
  spec.authors = ["Jay Ravaliya"]
  spec.email = ["jayrav13@gmail.com"]

  spec.summary = "TOaDO: Write a short summary, because RubyGems requires one."
  spec.description = "TOaDO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/jayrav13/trade_a_plane-client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = "https://github.com/jayrav13/trade_a_plane-client" # spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jayrav13/trade_a_plane-client"
  spec.metadata["changelog_uri"] = "https://github.com/jayrav13/trade_a_plane-client"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
