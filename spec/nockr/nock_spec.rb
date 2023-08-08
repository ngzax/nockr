# frozen_string_literal: true

describe Nockr do
  let(:noun1) {Nockr::Nock.parse("[[50 51] [0 1]]")}
  let(:noun2) {Nockr::Nock.parse("[[50 51] [0 2]]")}
  let(:noun8) {Nockr::Nock.parse("[[50 51] [0 8]]")}

  context "Nock Specification" do
    context "Nock 0" do
      # *[a 0 b]  /[b a]
      it "can get slot 1" do
        expect(noun1.subject.ary).to eq([50, 51])
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
        n = Nockr::Nock.parse("[[50 51] [0 [0 1]]]")
        expect {noun8.interpret}.to raise_error(ArgumentError)
      end
    end

    context "Nock 1" do
      # *[a 1 b]  b
      it "echos slot 7 regardless of the subject" do
        expect(Nockr::Nock.parse("[[20 30] [1 67]]").interpret).to eq(67)
      end

      it "echos slot 7 when it's a cell" do
        expect(Nockr::Nock.parse("[[20 30] [1 [2 587]]]").interpret.ary).to eq([2, 587])
        expect(Nockr::Nock.parse("[[20 30] [1 [2 587]]]").interpret.to_s).to eq('[2 587]')
      end
    end

    context "Nock 4" do
      # *[a 4 b]  +*[a b]
      it "increments a when it's an atom" do
        expect(Nockr::Nock.parse("[50 [4 0 1]]").interpret).to eq(51)
      end

      it "recursively increments a when it's an atom" do
        expect(Nockr::Nock.parse("[50 [4 4 0 1]]").interpret).to eq(52)
      end

      # it "echos slot 7 when it's a cell" do
      #   expect(Nockr::Nock.parse("[[20 30] [1 [2 587]]]").interpret.ary).to eq([2, 587])
      #   expect(Nockr::Nock.parse("[[20 30] [1 [2 587]]]").interpret.to_s).to eq('[2 587]')
      # end
    end
  end
end