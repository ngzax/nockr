Gem::Specification.new do |s|
  s.name                  = "nockr"
  s.summary               = "NockR"
  s.description           = "A Nock interpreter in Ruby"
  s.authors               = ["Daryl Richter"]
  s.email                 = "winter8@duck.com"

  s.files                 =  Dir.glob("lib{.rb,/**/*}", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }
  s.files                 += %w[nockr.gemspec]    # include the gemspec itself because warbler breaks w/o it

  s.homepage              = "https://rubygems.org/gems/nockr"
  s.license               = "BSD-3-Clause"
  s.require_paths         = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 3.2.2")
  s.version               = "0.0.1"
end