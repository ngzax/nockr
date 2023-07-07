require "nockr/noun"

describe Nockr::Noun do
  context "has right associativity" do
    it "single element array" do
      # [0] => [0]
      expect(Nockr::Noun.new(input_ary: [0]).interpret).to eq([0])
    end

    it "tuple cells" do
      # [0, 1] => [0, 1]
      expect(Nockr::Noun.new(input_ary: [0, 1]).interpret).to eq([0, 1])

      # ([[0, 1], 2], [[0, 1], 2]),
      expect(Nockr::Noun.new(input_ary: [[0, 1], 2]).interpret).to eq([[0, 1], 2])
    end

    it "3-tuples" do
      # [0, 1, 2] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, 1, 2]).interpret).to eq([0, [1, 2]])

      # [0, [1, 2]] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, [1, 2]]).interpret).to eq([0, [1, 2]])
    end

    it "4-tuples" do
      # [0, 1, 2, 3] => [0, [1, [2, 3]]]
      expect(Nockr::Noun.new(input_ary: [0, 1, 2, 3]).interpret).to eq([0, [1, [2, 3]]])
    end

    it "n-tuples" do
      expect(Nockr::Noun.new(input_ary: [1, 0, [541, 25, 99]]).interpret).to eq([1, [0, [541, [25, 99]]]])
    end
  end
end