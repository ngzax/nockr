require 'nockr/noun'

module Nockr
  class Atom < Noun

    def initialize(i)
      raise ArgumentError.new("an Atom must be initialized with a Natural Number") unless i.is_a? Integer
      @i = i
    end

    def at(index:)
      i
    end
  end
end