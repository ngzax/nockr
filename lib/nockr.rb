# frozen_string_literal: true

module Nockr
  require_relative "nockr/noun"
  require_relative "nockr/atom"
  require_relative "nockr/cell"
  require_relative "nockr/version"

  class << self
    def nock(input)
      n = Noun.from_ary input
      puts "Interpreting #{input} as Nock..."
      puts "=> #{n.interpret}"
    end
  end
end

# extend Nockr::Atom
