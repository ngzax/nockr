require "nockr/atom"
require "nockr/cell"

describe Nockr::Cell do
  let(:atom0) {Nockr::Atom.new(0)}
  let(:atom1) {Nockr::Atom.new(1)}

  let(:cella0a1) {described_class.new(head: atom0, tail: atom1)}
  # let(:atom1) {described_class.new(1)}

  context "can be compared" do
    it "is equal to itself" do
      expect(cella0a1).to eq(cella0a1)
    end
  end

  context "interface" do
    it "returns itself for any index 1" do
      # [1 a] => a
      expect(cella0a1.at(index: 1)).to eq(cella0a1)
    end

    it "returns the head for index 2" do
      # [2 a b] => a
      expect(cella0a1.at(index: 2)).to eq(atom0)
    end

    it "returns the tail for index 3" do
      # [3 a b] => b
      expect(cella0a1.at(index: 3)).to eq(atom1)
    end

    it "crashes on invalid indexes" do
      expect {cella0a1.at(index: 0)}.to raise_error(ArgumentError)
      expect {cella0a1.at(index: 8)}.to raise_error(ArgumentError)
    end
  end
end