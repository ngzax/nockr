require_relative 'lib/nockr/version'

Gem::Specification.new do |s|
  s.name        = "nockr"
  s.summary     = %q{A Nock interpreter in Ruby}
  s.description = %q{Nock is Urbit's assembly language. This gem lets you interpret and run it from Ruby."}
  s.authors     = ["Daryl Richter"]
  s.email       = ["winter8@duck.com"]
  s.version     = Nockr::VERSION

  s.homepage    = "https://rubygems.org/gems/nockr"
  s.license     = "BSD-3-Clause"

  s.required_ruby_version = Gem::Requirement.new(">= 3.2.2")

  s.metadata["homepage_uri"]    = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/Zaxonomy/nockr"
  s.metadata["changelog_uri"]   = "https://github.com/Zaxonomy/nockr/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  s.files =  Dir.glob("lib{.rb,/**/*}", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }
  s.files += %w[nockr.gemspec]    # include the gemspec itself because warbler breaks w/o it

  s.bindir        = "bin"
  s.require_paths = ["lib"]

  s.add_development_dependency "pry",   "~> 0.13"
  s.add_development_dependency "rspec", "~> 3.10"
end
