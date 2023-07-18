require "nockr/atom"

describe Nockr::Atom do
  let(:atom0) {described_class.new(0)}
  let(:atom1) {described_class.new(1)}

  context "initialization" do
    it "is must be initialized with a natural number" do
      expect {Nockr::Atom.new("a")}.to raise_error(ArgumentError)
    end
  end

  context "can be compared" do
    it "is equal to itself" do
      expect(atom0).to eq(atom0)
    end
  end

  context "interface" do
    it "returns itself for any index" do
      # [0] => [0]
      expect(atom0.at(index: 1)).to eq(atom0)
      expect(atom0.at(index: 8)).to eq(atom0)
    end

  #   it "for tuple cells" do
  #     # [0, 1] => [0, 1]
  #     expect(cell.interpret).to eq([0, 1])

  #     # ([[0, 1], 2], [[0, 1], 2]),
  #     expect(Nockr::Noun.new(input_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
  #   end

  #   it "for 3-tuples" do
  #     # [0, 1, 2] => [0, [1, 2]]
  #     expect(Nockr::Noun.new(input_ary: [0, 1, 2]).interpret).to eq([0, [1, 2]])

  #     # [0, [1, 2]] => [0, [1, 2]]
  #     expect(Nockr::Noun.new(input_ary: [0, [1, 2]]).interpret).to eq([0, [1, 2]])
  #   end

  #   it "for 4-tuples" do
  #     # [0, 1, 2, 3] => [0, [1, [2, 3]]]
  #     expect(Nockr::Noun.new(input_ary: [0, 1, 2, 3]).interpret).to eq([0, [1, [2, 3]]])
  #   end

  #   it "for n-tuples" do
  #     expect(Nockr::Noun.new(input_ary: [1, 0, [541, 25, 99]]).interpret).to eq([1, [0, [541, [25, 99]]]])
  #   end
  # end

  # context "can retrieve sub-Noun at an index" do
  #   it "for tuple cells" do
  #     # 1 is the tree root
  #     expect(cell.at(index: 1)).to eq(cell)

  #     # The head of every node n is 2n
  #     expect(cell.at(index: 2)).to eq(atom1)

  #     # ([[0, 1], 2], [[0, 1], 2]),
  #     # expect(Nockr::Noun.new(input_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
  #   end
  end
end