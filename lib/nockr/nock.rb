# frozen_string_literal: true

module Nockr
  class Nock < Cell
    class << self
      def parse(a_noun)
        n = Noun.from_ary(Noun.to_ary(a_noun))
        new(head: n.h, tail: n.t)
      end
    end

    def formula
      self.at(index: 3)
    end

    def interpret
      raise "Cannot interpret without [[subject] [formula]]" unless self.nock?
      if 0 == self.opcode.i
        raise ArgumentError.new("Slot must be an Atom") unless self.slot.is_a? Atom
        return self.subject.at(index: self.slot.i)
      elsif 1 == self.opcode.i
        return self.slot
      end
      base = Noun.from_ary(self.subject.ary << self.formula.at(index: 3).ary)
      n = Nock.parse(base.to_s).interpret
      n.i += 1
    end

    def nock?
      true
    end

    def opcode
      self.formula.at(index: 2)
    end

    def slot
      self.formula.at(index: 3)
    end

    def subject
      self.at(index: 2)
    end
  end
end