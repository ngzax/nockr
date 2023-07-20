# frozen_string_literal: true

module Nockr
  class Atom < Noun
    attr_reader :i

    def initialize(i)
      raise ArgumentError.new("an Atom must be initialized with a Natural Number") unless i.is_a? Integer
      @i = i
    end

    def ary
      [self.i]
    end

    def at(index:)
      self
    end

    def atom?
      true
    end

    def cell?
      false
    end
  end
end