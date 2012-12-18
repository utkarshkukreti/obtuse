require "spec_helper"

describe Obtuse do
  it "should have a VERSION" do
    Obtuse::VERSION.should be_a String
  end

  describe "Integer" do
    e "2", 2
    e "100", 100
  end

  describe "String" do
    e %q{"a \n b \n c \t\td\na"}, "a \n b \n c \t\td\na"
  end

  describe "Integer Integer" do
    describe "+" do
      e "2 1+", 3
      e "10 20 +", 30
    end

    describe "-" do
      e "2 3-", -1
      e "10 20 -", -10
    end

    describe "*" do
      e "2 3*", 6
      e "10 20 *", 200
    end

    describe "/" do
      e "2 3/", 0
      e "10 20 /", 0
    end

    describe "%" do
      e "2 3%", 2
      e "10 20 %", 10
    end

    describe "^" do
      e "2 3^", 8
      e "10 20 ^", 10 ** 20
    end

    describe "Combination" do
      e "1 2+3-", 0
      e "5 1 4 5 2 3 4 +-+-+-", 0
    end
  end

  describe "String String" do
    describe "+" do
      e '"foo""bar"+', "foobar"
      e '"foo" "bar"+', "foobar"
      e '"foo\\"" "bar"+', 'foo"bar'
    end
  end
end
