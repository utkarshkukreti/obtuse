require "spec_helper"

describe Obtuse do
  it "should have a VERSION" do
    Obtuse::VERSION.should be_a String
  end

  describe "Integer" do
    describe "" do
      e "2", 2
      e "100", 100
      e "-10", -10
    end

    describe "#" do
      e "3#", [0, 1, 2]
    end
  end

  describe "String" do
    describe "" do
      e %q{"a \n b \n c \t\td\na"}, "a \n b \n c \t\td\na"
    end

    describe "#" do
      e %q{"foo bar"#}, 7
    end

    describe "$" do
      e %q{"abcdcba"$}, "aabbccd"
    end
  end

  describe "Integer Integer" do
    describe "+" do
      e "2 1+", 3
      e "10 20 +", 30
      e "2 -3+", -1
    end

    describe "-" do
      e "2 3-", -1
      e "10 20 -", -10
      e "-10 -20-", 10
    end

    describe "*" do
      e "2 3*", 6
      e "10 20 *", 200
      e "-5 5*", -25
    end

    describe "/" do
      e "2 3/", 0
      e "10 20 /", 0
      e "10 -2/", -5
    end

    describe "%" do
      e "2 3%", 2
      e "10 20 %", 10
      e "5 -3%", -1
    end

    describe "^" do
      e "2 3^", 8
      e "10 20 ^", 10 ** 20
      e "-3 3^", -27
    end

    describe "Combination" do
      e "1 2+3-", 0
      e "5 1 4 5 2 3 4 +-+-+-", 0
      e "1-2-3-+", 2
      e "1-2- 3+", 6
    end
  end

  describe "String String" do
    describe "+" do
      e '"foo""bar"+', "foobar"
      e '"foo" "bar"+', "foobar"
      e '"foo\\"" "bar"+', 'foo"bar'
    end

    describe "-" do
      e %q{"aaa""a"-}, ""
      e %q{"cabc""b"-}, "cac"
      e %q{"cabc""cb"-}, "a"
      e %q{"cabc""cab"-}, ""
    end
  end

  describe "String Integer" do
    describe "+" do
      e %q{"foo: "42+}, "foo: 42"
    end

    describe "-" do
    end

    describe "*" do
      e %q{"foobar "3*}, "foobar foobar foobar "
    end

    describe "/" do
    end

    describe "%" do
      e %q{"%05d" 123%}, "00123"
    end

    describe "^" do
    end
  end

  describe "String Array" do
    describe "%" do
      e %q{"%02d %03d %04d"4#%}, "00 001 0002"
    end
  end

  describe "Array" do
    describe "#" do
      e "10##", 10
    end
  end

  describe "" do
    describe "Ia" do
      e "Ia", "abc\nbcd", "abc\nbcd"
    end

    describe "Il" do
      e "Il", "abc", "abc\nbcd"
    end
  end
end
