require "nockr/noun"

describe NockR::Noun do
  context "have right associativity" do
    it "doesn't touch a simple cell" do
      # [0, 1] => [0, 1]
      expect(Noun.new([0, 1]).interpret).to eq([1, 2])
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