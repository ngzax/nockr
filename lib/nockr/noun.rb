# frozen_string_literal: true

module Nockr
  class Noun
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
        return Cell.new(head: nonify(ary[0]), tail: nonify(ary[1..]))
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

    def interpret
      raise "Cannot interpret without [[subject] [formula]]" unless self.nock?
      self
    end
  end
end