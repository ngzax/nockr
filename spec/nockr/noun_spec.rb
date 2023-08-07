# frozen_string_literal: true

describe Nockr::Noun do
  let(:atom0) {Nockr::Atom.new(0)}
  let(:atom1) {Nockr::Atom.new(1)}

  # cell with [atom atom]
  let(:cell_aa) {Nockr::Cell.new(head: atom0, tail: atom1)}

  let(:noun0) {described_class.from_ary [0, 1]}
  let(:noun1) {described_class.from_ary [[0, 1], 2]}
  let(:noun2) {described_class.from_ary [[0, 1], [2, [3, 4]]]}

  context "can be compared" do
    it "is equal to itself" do
      expect(noun0).to eq(noun0)
    end

    it "is equal if internal tuple tree is identical" do
      expect(noun0).to eq(Nockr::Noun.from_ary [0, 1])
    end
  end

  context "has right associativity" do
    it "for single element array" do
      # [0] => [0]
      expect((Nockr::Noun.from_ary [0]).ary).to eq([0])
    end

    it "for tuple nouns" do
      # [0, 1] => [0, 1]
      expect((Nockr::Noun.from_ary [0, 1]).ary).to eq([0, 1])

      # ([[0, 1], 2], [[0, 1], 2]),
      expect(noun1.ary).to eq([[0, 1], 2])
    end

    it "for 3-tuples" do
      # [0, 1, 2] => [0, [1, 2]]
      expect((Nockr::Noun.from_ary [0, 1, 2]).ary).to eq([0, [1, 2]])

      # [0, [1, 2]] => [0, [1, 2]]
      expect((Nockr::Noun.from_ary [0, [1, 2]]).ary).to eq([0, [1, 2]])
    end

    it "for 4-tuples" do
      # [0, 1, 2, 3] => [0, [1, [2, 3]]]
      expect((Nockr::Noun.from_ary [0, 1, 2, 3]).ary).to eq([0, [1, [2, 3]]])
    end

    it "for n-tuples" do
      expect((Nockr::Noun.from_ary [1, 0, [541, 25, 99]]).ary).to eq([1, [0, [541, [25, 99]]]])

      # Real Nock
      expect((Nockr::Noun.from_ary [ [2, [3, 4] ], [0, 1] ]).ary).to eq([[2, [3, 4]], [0, 1]])
    end
  end

  context "can retrieve sub-Noun at an index" do
    it "for tuple nouns" do
      # 1 is the tree root
      # /[1 a] => a
      expect(noun0.at(index: 1)).to eq(noun0)

      # The head of every node n is 2n
      # /[2 a b] => a
      expect(noun0.at(index: 2)).to eq(atom0)

      # The tail of every node n is 2n - 1
      # /[3 a b] => b
      expect(noun0.at(index: 3)).to eq(atom1)

      # [[0 1] 2]
      expect(noun1.at(index: 1).ary).to eq([[0, 1], 2])
      expect(noun1.at(index: 2)).to eq(cell_aa)
      expect(noun1.at(index: 3)).to eq(Nockr::Atom.new(2))

      expect(noun1.at(index: 4)).to eq(atom0)
      expect(noun1.at(index: 5)).to eq(atom1)

      expect {noun1.at(index: 6)}.to raise_error(ArgumentError)
      expect {noun1.at(index: 7)}.to raise_error(ArgumentError)

      # [[0 1] [2 [3 4]]]
      expect(noun2.at(index: 1).ary).to eq([[0, 1], [2, [3, 4]]])
      expect(noun2.at(index: 2).ary).to eq([0, 1])
      expect(noun2.at(index: 3).ary).to eq([2, [3, 4]])

      expect(noun2.at(index: 4)).to eq(0)
      expect(noun2.at(index: 5)).to eq(1)

      expect(noun2.at(index: 6)).to eq(2)
      expect(noun2.at(index: 7).ary).to eq([3, 4])

      expect {noun1.at(index: 8)}.to raise_error(ArgumentError)
      expect {noun1.at(index: 9)}.to raise_error(ArgumentError)

      expect(noun2.at(index: 14)).to eq(3)
      expect(noun2.at(index: 15)).to eq(4)
      expect {noun1.at(index: 16)}.to raise_error(ArgumentError)
    end
  end

  context "urbit syntax" do
    # e.g. in the urbit dojo and code a cell looks like: [a b c d] as shorthand for [a [b [c d]]]
    it "can accept a simple string in urbit 'cell' format" do
      expect(Nockr::Noun.raw('[0 1 2 3]').ary).to eq([0, [1, [2, 3]]])
      expect(Nockr::Noun.raw('[0 1 2 3]').at(index: 1).ary).to eq([0, [1, [2, 3]]])
      expect(Nockr::Noun.raw('[0 1 2 3]').at(index: 2)).to eq(0)
      expect(Nockr::Noun.raw('[0 1 2 3]').at(index: 3).ary).to eq([1, [2, 3]])
      expect(Nockr::Noun.raw('[0 1 2 3]').at(index: 6)).to eq(1)
    end

    it "can accept a complex string in urbit 'cell' format" do
      expect(Nockr::Noun.from_ary([[50,51],[0,2]]).ary).to eq([[50, 51], [0, 2]])
      expect(Nockr::Noun.raw("[[50 51] [0 2]]").ary).to    eq([[50, 51], [0, 2]])
    end
  end

  context "Nock Specification" do
    context "Nock 0" do
      let(:noun1) {Nockr::Noun.raw("[[50 51] [0 1]]")}
      let(:noun2) {Nockr::Noun.raw("[[50 51] [0 2]]")}
      let(:noun8) {Nockr::Noun.raw("[[50 51] [0 8]]")}

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
        n = Nockr::Noun.raw("[[50 51] [0 [0 1]]]")
        expect {noun8.interpret}.to raise_error(ArgumentError)
      end
    end

    context "Nock 1" do
      # *[a 1 b]  b
      it "echos slot 7 regardless of the subject" do
        expect(Nockr::Noun.raw("[[20 30] [1 67]]").interpret).to eq(67)
      end

      it "echos slot 7 when its a cell" do
        expect(Nockr::Noun.raw("[[20 30] [1 [2 587]]]").interpret.ary).to eq([2, 587])
      end
    end
  end
end