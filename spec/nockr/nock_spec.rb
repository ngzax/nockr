# frozen_string_literal: true

describe Nockr do
  let(:noun1) {Nockr::Noun.raw("[[50 51] [0 1]]")}
  let(:noun2) {Nockr::Noun.raw("[[50 51] [0 2]]")}
  let(:noun8) {Nockr::Noun.raw("[[50 51] [0 8]]")}

  context "Nock 0" do
    it "can get slot 1" do
      expect(noun1.opcode).to eq(0)
      expect(noun1.slot).to eq(1)
      expect(noun1.interpret).to eq(Nockr::Cell.new(head: 50, tail: 51))
      expect(noun1.interpret.ary).to eq([50, 51])
    end

    it "can get slot 2" do
      expect(noun2.opcode).to eq(0)
      expect(noun2.slot).to eq(2)
      expect(noun2.interpret).to eq(50)
    end

    it "crashes on a bad atom slot" do
      expect(noun8.opcode).to eq(0)
      expect(noun8.slot).to eq(8)
      expect {noun8.interpret}.to raise_error(ArgumentError)
    end

    it "crashes on a cell in the slot" do
      n = Nockr::Noun.raw("[[50 51] [0 [0 1]]]")
      expect {noun8.interpret}.to raise_error(ArgumentError)
    end
  end
end