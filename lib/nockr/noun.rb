module Nockr
  class Noun
    attr_reader :i

    def initialize(input_ary:)
      raise ArgumentError.new("a Noun must be initialized with an Array") unless input_ary.is_a? Array
      @i = input_ary
    end

    def ==(another_noun)
      another_noun.i == self.i
    end

    def at(index:)
      return self if 1 == index
      Noun.new(input_ary: [1])
    end

    def interpret
      @n = self.to_tuples @i
      # return "Interpreting #{@n} as Nock."
    end

    def to_a
      @n
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