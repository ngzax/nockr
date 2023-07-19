# frozen_string_literal: true

describe Nockr::Noun do
  let(:atom0) {Nockr::Atom.new(0)}
  let(:atom1) {Nockr::Atom.new(1)}

  # cell with [atom atom]
  let(:cell_aa) {Nockr::Cell.new(head: atom0, tail: atom1)}

  let(:noun) {described_class.new(from_ary: [0, 1])}

  context "can be compared" do
    it "is equal to itself" do
      expect(noun).to eq(noun)
    end

    it "is equal if internal tuple tree is identical" do
      expect(noun).to eq(Nockr::Noun.new(from_ary: [0, 1]))
    end
  end

  context "has right associativity" do
    it "for single element array" do
      # [0] => [0]
      expect(Nockr::Noun.new(from_ary: [0]).ary).to eq([0])
    end

    it "for tuple nouns" do
      # [0, 1] => [0, 1]
      expect(Nockr::Noun.new(from_ary: [0, 1]).ary).to eq([0, 1])

      # ([[0, 1], 2], [[0, 1], 2]),
      expect(Nockr::Noun.new(from_ary: [[0, 1], 2]).ary).to eq([[0, 1], 2])
    end

    it "for 3-tuples" do
      # [0, 1, 2] => [0, [1, 2]]
      expect(Nockr::Noun.new(from_ary: [0, 1, 2]).ary).to eq([0, [1, 2]])

      # [0, [1, 2]] => [0, [1, 2]]
      expect(Nockr::Noun.new(from_ary: [0, [1, 2]]).ary).to eq([0, [1, 2]])
    end

    it "for 4-tuples" do
      # [0, 1, 2, 3] => [0, [1, [2, 3]]]
      expect(Nockr::Noun.new(from_ary: [0, 1, 2, 3]).ary).to eq([0, [1, [2, 3]]])
    end

    it "for n-tuples" do
      expect(Nockr::Noun.new(from_ary: [1, 0, [541, 25, 99]]).ary).to eq([1, [0, [541, [25, 99]]]])
    end
  end

  context "can retrieve sub-Noun at an index" do
    it "for tuple nouns" do
      # 1 is the tree root
      expect(noun.at(index: 1)).to eq(noun)

      # The head of every node n is 2n
      expect(noun.at(index: 2)).to eq(atom0)

      # The tail of every node n is 2n - 1
      expect(noun.at(index: 3)).to eq(atom1)

      # ([[0, 1], 2], [[0, 1], 2]),
      # expect(Nockr::Noun.new(from_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
    end
  end
end