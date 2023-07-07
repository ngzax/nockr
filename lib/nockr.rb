require "nockr/noun"

module Nockr
  class << self
    def nock(input)
      n = Noun.new input_ary: input
      puts "Interpreting #{input} as Nock..."
      puts "=> #{n.interpret}"
    end
  end
end