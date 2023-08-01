# frozen_string_literal: true

module Nockr
  class Noun
    attr_reader :ary, :n

    class << self
      def from_ary(ary)
        raise ArgumentError.new("a Noun must be initialized with an Array") unless ary.is_a? Array
        @ary = to_tuples ary
        @n = nonify @ary
      end

      def nonify(ary)
        return Atom.new(ary) unless ary.is_a? Array
        return Atom.new(ary[0]) if 1 == ary.size
        return Cell.new(head: nonify(ary[0]), tail: nonify(ary[1])) if 2 == ary.size
        return [ary[0], nonify(ary[1..])]
      end

      #
      # [a b c]  [a [b c]]
      #
      # q.v. https://github.com/belisarius222/pynock
      #
      def to_tuples(ary)
        return ary unless ary.is_a? Array
        return ary if 1 == ary.size
        return [to_tuples(ary[0]), to_tuples(ary[1])] if 2 == ary.size
        return [ary[0], to_tuples(ary[1..])]
      end
    end

    def initialize(from_ary:)
      raise "Cannot initialize an abstract Noun class"
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
  end
end