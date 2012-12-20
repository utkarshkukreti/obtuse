require "spec_helper"

describe Obtuse do
  it "should have a VERSION" do
    Obtuse::VERSION.should be_a String
  end

  describe "Primitives" do
    describe "Integer" do
      e "2", 2
      e "100", 100
      e "-10", -10
    end

    describe "String" do
      e %q{"a \n b \n c \t\td\na"}, "a \n b \n c \t\td\na"
    end
  end

  describe "Mixture" do
    e "1 2+3-", 0
    e "5 1 4 5 2 3 4 +-+-+-", 0
    e "1-2-3-+", 2
    e "1-2- 3+", 6
  end
end
