# frozen_string_literal: true

describe Nockr::Cell do
  let(:atom0) {Nockr::Atom.new(0)}
  let(:atom1) {Nockr::Atom.new(1)}

  # cell with [atom atom]
  let(:cell_aa) {described_class.new(head: atom0, tail: atom1)}

  # cell with [atom cell]
  let(:cell_ac) {described_class.new(head: atom0, tail: cell_aa)}

  # cell with [cell atom]
  let(:cell_ca) {described_class.new(head: cell_ac, tail: atom0)}

  # cell with [cell cell]
  let(:cell_cc) {described_class.new(head: cell_ac, tail: cell_ca)}

  context "comparing" do
    it "is equal to itself" do
      expect(cell_aa).to eq(cell_aa)
    end
  end

  context "converting" do
    it "can be represented as an array" do
      expect(cell_aa.ary).to eq([0, 1])
      expect(cell_ac.ary).to eq([0, [0, 1]])
      expect(cell_ca.ary).to eq([[0, [0, 1]], 0])
      #                           cellac      cellca
      expect(cell_cc.ary).to eq([[0, [0, 1]], [[0, [0, 1]], 0]])
    end
  end

  context "testing" do
    it "knows its a cell" do
      expect(cell_aa.cell?).to be true
    end

    it "knows its not an atom" do
      expect(cell_aa.atom?).to be false
    end
  end

  context "indexing interface" do
    it "returns itself for index 1" do
      # [1 a] => a
      expect(cell_aa.at(index: 1)).to eq(cell_aa)
      expect(cell_cc.at(index: 1)).to eq(cell_cc)
    end

    it "returns the head for index 2" do
      # [2 a b] => a
      expect(cell_aa.at(index: 2)).to eq(atom0)

      # the head can be a Cell...
      expect(cell_ca.at(index: 2)).to eq(cell_ac)
    end

    it "returns the tail for index 3" do
      # [3 a b] => b
      expect(cell_aa.at(index: 3)).to eq(atom1)

      # the tail can be a Cell...
      expect(cell_ac.at(index: 3)).to eq(cell_aa)
    end

    it "crashes on invalid indexes" do
      expect {cell_aa.at(index: 0)}.to raise_error(ArgumentError)
      expect {cell_aa.at(index: 8)}.to raise_error(ArgumentError)
    end
  end
end