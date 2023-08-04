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
      raise ArgumentError.new("Invalid Index.") if index < 1

      return self if 1 == index
      return @h   if 2 == index
      return @t   if 3 == index

      bin = index.to_s(2)
      bin.slice!(0)
      raise ArgumentError.new("Invalid Index.") if bin.nil?

      non = self
      depth = 0

      bin.each_char do |b|
        depth += 1
        if non.cell?
          non = ('0' == b) ? non.h : non.t
        else
          raise ArgumentError.new("Invalid Index.") unless depth < bin.length
        end
      end

      non
    end

    def atom?
      false
    end

    def cell?
      true
    end

    def formula
      self.at(index: 3)
    end

    def nock?
      self.h.cell? && self.t.cell?
    end

    def subject
      self.at(index: 2)
    end

    def to_s
      "[#{self.h} #{self.t}]"
    end
  end
end