# frozen_string_literal: true

module Nockr
  class Cell < Noun
    attr_reader :h, :t

    def initialize(head:, tail:)
      @h = head
      @t = tail
    end

    def ==(another_cell)
      another_cell.h == self.h && another_cell.t == self.t
    end

    def ary
      [@h.cell? ? @h.ary : @h.i, @t.cell? ? @t.ary : @t.i]
    end

    def at(index:)
      raise ArgumentError.new("Invalid Index.") if index < 1 || index > 3
      return self if 1 == index
      return @h if 2 == index
      return @t if 3 == index
    end

    def atom?
      false
    end

    def cell?
      true
    end
  end
end