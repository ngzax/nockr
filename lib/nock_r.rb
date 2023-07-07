require "nockr/noun"

module NockR
  class << self
    def nock(input)
      n = NockR::Noun.new input_ary: input
      puts "#{n.interpret}"
    end
  end
end