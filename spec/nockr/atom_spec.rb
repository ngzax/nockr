# frozen_string_literal: true

describe Nockr::Atom do
  let(:atom0) {described_class.new(0)}
  let(:atom1) {described_class.new(1)}

  context "initialization" do
    it "is must be initialized with a natural number" do
      expect {Nockr::Atom.new("a")}.to raise_error(ArgumentError)
    end
  end

  context "comparing" do
    it "is equal to itself" do
      expect(atom0).to eq(atom0)
    end
  end

  context "converting" do
    it "can be represented as an array" do
      expect(atom0.ary).to eq([0])
    end
  end

  context "testing" do
    it "knows its an atom" do
      expect(atom0.atom?).to be true
    end

    it "knows its not a cell" do
      expect(atom0.cell?).to be false
    end
  end

  context "interface" do
    it "returns itself for any index" do
      # [0] => [0]
      expect(atom0.at(index: 1)).to eq(atom0)
      expect(atom0.at(index: 8)).to eq(atom0)
    end
  end
end