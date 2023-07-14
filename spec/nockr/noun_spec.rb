require "nockr/noun"

describe Nockr::Noun do
  let(:atom0) {described_class.new(input_ary: [0])}
  let(:atom1) {described_class.new(input_ary: [1])}
  let(:cell) {described_class.new(input_ary: [0, 1])}

  context "can be compared" do
    it "is equal to itself" do
      expect(cell).to eq(cell)
    end

    it "is equal if internal tree is identical" do
      expect(cell).to eq(Nockr::Noun.new(input_ary: [0, 1]))
    end
  end

  context "has right associativity" do
    it "for single element array" do
      # [0] => [0]
      expect(Nockr::Noun.new(input_ary: [0]).interpret).to eq(atom0.interpret)
    end

    it "for tuple cells" do
      # [0, 1] => [0, 1]
      expect(cell.interpret).to eq([0, 1])

      # ([[0, 1], 2], [[0, 1], 2]),
      expect(Nockr::Noun.new(input_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
    end

    it "for 3-tuples" do
      # [0, 1, 2] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, 1, 2]).interpret).to eq([0, [1, 2]])

      # [0, [1, 2]] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, [1, 2]]).interpret).to eq([0, [1, 2]])
    end

    it "for 4-tuples" do
      # [0, 1, 2, 3] => [0, [1, [2, 3]]]
      expect(Nockr::Noun.new(input_ary: [0, 1, 2, 3]).interpret).to eq([0, [1, [2, 3]]])
    end

    it "for n-tuples" do
      expect(Nockr::Noun.new(input_ary: [1, 0, [541, 25, 99]]).interpret).to eq([1, [0, [541, [25, 99]]]])
    end
  end

  context "can retrieve sub-Noun at an index" do
    it "for tuple cells" do
      # 1 is the tree root
      expect(cell.at(index: 1)).to eq(cell)

      # The head of every node n is 2n
      expect(cell.at(index: 2)).to eq(atom1)

      # ([[0, 1], 2], [[0, 1], 2]),
      # expect(Nockr::Noun.new(input_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
    end
  end
end