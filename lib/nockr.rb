# frozen_string_literal: true

module Nockr
  require "nockr/noun"
  require "nockr/atom"
  require "nockr/cell"
  require "nockr/version"

  class << self
    def nock(input)
      n = Noun.new input_ary: input
      puts "Interpreting #{input} as Nock..."
      puts "=> #{n.interpret}"
    end
  end
end

# extend Nockr::Atom
