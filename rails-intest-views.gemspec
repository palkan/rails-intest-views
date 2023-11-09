# frozen_string_literal: true

require_relative "lib/rails-intest-views/version"

Gem::Specification.new do |s|
  s.name = "rails-intest-views"
  s.version = RailsIntestViews::VERSION
  s.authors = ["Vladimir Dementyev"]
  s.email = ["Vladimir Dementyev"]
  s.homepage = "https://github.com/palkan/rails-intest-views"
  s.summary = "Generate view templates dynamically in Rails tests"
  s.description = "Generate view templates dynamically in Rails tests"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/palkan/rails-intest-views/issues",
    "changelog_uri" => "https://github.com/palkan/rails-intest-views/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/palkan/rails-intest-views",
    "homepage_uri" => "https://github.com/palkan/rails-intest-views",
    "source_code_uri" => "https://github.com/palkan/rails-intest-views"
  }

  s.license = "MIT"

  s.files = Dir.glob("app/**/*") + Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "combustion", ">= 1.1"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "minitest-focus"
  s.add_development_dependency "minitest-reporters"
end
