require 'nockr/noun'

module Nockr
  class Cell < Noun

    def initialize(head:, tail:)
      @h = head
      @t = tail
    end

    def at(index:)
      raise ArgumentError.new("Invalid Index.") if index < 1 || index > 3
     return self if 1 == index
     return @h if 2 == index
     return @t if 3 == index
    end
  end
end