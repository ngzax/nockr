# Run me with:
#   $ observr specs.watchr

# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '^lib/nockr/(.*)\.rb'        ){ |m| bundle exec "rspec -f d spec"}
watch( '^spec/nockr/(.*)_spec.*\.rb'){ |m| bundle exec "rspec -f d spec"}

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { ruby tests  } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def ruby(*paths)
  run "ruby #{gem_opt} -I.:lib:test -e'%w( #{paths.flatten.join(' ')} ).each {|p| require p }'"
end

def tests
  Dir['test/**/test_*.rb'] - ['test/test_helper.rb']
end

def run( cmd )
  puts   cmd
  system cmd
end

def gem_opt
  defined?(Gem) ? "-rubygems" : ""
end
