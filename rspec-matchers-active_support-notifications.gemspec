# frozen_string_literal: true

require_relative "lib/rspec/matchers/active_support/notifications/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-matchers-active_support-notifications"
  spec.version = Rspec::Matchers::ActiveSupport::Notifications::VERSION
  spec.authors = ["Jose D. Gomez R."]
  spec.email = ["jose.gomez@suse.com"]

  spec.summary = "RSpec matchers for ActiveSupport Notifications"
  spec.description = spec.summary
  spec.homepage = "https://github.com/josegomezr/rspec-matchers-active_support-notifications"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/josegomezr/rspec-matchers-active_support-notifications"
  spec.metadata["changelog_uri"] = "https://github.com/josegomezr/rspec-matchers-active_support-notifications/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rspec-core", "~> 3"
  spec.add_dependency "activesupport", ">= 6.0"
end
