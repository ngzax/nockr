# frozen_string_literal: true

module Nockr
  class Atom < Noun
    attr_accessor :i

    def initialize(i)
      raise ArgumentError.new("an Atom must be initialized with a Natural Number") unless i.is_a? Integer
      @i = i
    end

    def ==(another_atom)
      another_atom.i == self.i || another_atom == self.i
    end

    def ary
      [self.i]
    end

    def at(index:)
      raise ArgumentError.new("an Atom has no index > 1") unless 1 == index
      self
    end

    def atom?
      true
    end

    def cell?
      false
    end

    def increment
      self.i += 1
    end

    def nock?
      false
    end

    def to_s
      "#{self.i}"
    end
  end
end