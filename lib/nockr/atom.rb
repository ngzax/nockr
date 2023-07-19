# frozen_string_literal: true

module Nockr
  class Atom < Noun

    def initialize(i)
      raise ArgumentError.new("an Atom must be initialized with a Natural Number") unless i.is_a? Integer
      @ary = [i]
    end

    def at(index:)
      self
    end
  end
end