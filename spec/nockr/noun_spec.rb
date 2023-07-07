require "nockr/noun"

describe Nockr::Noun do
  context "have right associativity" do
    it "single element array" do
      # [0] => [0]
      expect(Nockr::Noun.new(input_ary: [0]).interpret).to eq([0])
    end

    it "simple tuple cell" do
      # [0, 1] => [0, 1]
      expect(Nockr::Noun.new(input_ary: [0, 1]).interpret).to eq([0, 1])
    end

    it "3-tuples" do
      # [0, 1, 2] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, 1, 2]).interpret).to eq([0, [1, 2]])

      # [0, [1, 2]] => [0, [1, 2]]
      expect(Nockr::Noun.new(input_ary: [0, [1, 2]]).interpret).to eq([0, [1, 2]])
    end
  end

  # def test_any_hello
  #   assert_equal "hello world",
  #     Hola.hi("ruby")
  # end

  # def test_spanish_hello
  #   assert_equal "hola mundo",
  #     Hola.hi("spanish")
  # end
end