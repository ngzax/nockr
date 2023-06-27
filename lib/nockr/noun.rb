module NockR
  class Noun
    def initialize(input_ary:)
      raise ArgumentError.new("a Noun must be initialized with an Array") unless input_ary.is_a? Array
      @i = input_ary
    end

    def interpret
      @n = self.to_tuples @i
      return "Interpreting #{@n} as Nock."
    end

    #
    # q.v. https://github.com/belisarius222/pynock
    #
    def to_tuples(ary)
      return ary unless ary.is_a? Array
      return [self.to_tuples(ary[0]), self.to_tuples(ary[1])] if 2 == ary.size
      return [ary[0], self.to_tuples(ary[1..])]
    end
  end
end