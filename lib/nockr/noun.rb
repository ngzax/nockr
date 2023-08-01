# frozen_string_literal: true

module Nockr
  class Noun
    attr_reader :ary, :n

    def initialize(from_ary:)
      raise ArgumentError.new("a Noun must be initialized with an Array") unless from_ary.is_a? Array
      @ary = self.to_tuples from_ary
      @n = self.nonify @ary
    end

    def ==(another_noun)
      another_noun.ary == self.ary
    end

    def at(index:)
      return self if 1 == index
      return self.n.at(index: index) if index < 4
      n = index / 2
      r = (index % 2) - 1
      return self.n.at(index: n).at(index: n + r)
    end

    # private

    def nonify(ary)
      return Atom.new(ary) unless ary.is_a? Array
      return Atom.new(ary[0]) if 1 == ary.size
      return Cell.new(head: self.nonify(ary[0]), tail: self.nonify(ary[1])) if 2 == ary.size
      return [ary[0], self.nonify(ary[1..])]
    end

    #
    # [a b c]  [a [b c]]
    #
    # q.v. https://github.com/belisarius222/pynock
    #
    def to_tuples(ary)
      return ary unless ary.is_a? Array
      return ary if 1 == ary.size
      return [self.to_tuples(ary[0]), self.to_tuples(ary[1])] if 2 == ary.size
      return [ary[0], self.to_tuples(ary[1..])]
    end
  end
end