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

  describe "Functions" do
    describe "+" do
      describe "Integer Integer" do
        e "2 1+", 3
        e "10 20 +", 30
        e "2 -3+", -1
      end

      describe "String Integer" do
          e %q{"foo: "42+}, "foo: 42"
      end

      describe "String String" do
        e '"foo""bar"+', "foobar"
        e '"foo" "bar"+', "foobar"
        e '"foo\\"" "bar"+', 'foo"bar'
      end
    end

    describe "-" do
      describe "Integer Integer" do
        e "2 3-", -1
        e "10 20 -", -10
        e "-10 -20-", 10
      end

      describe "String String" do
        e %q{"aaa""a"-}, ""
        e %q{"cabc""b"-}, "cac"
        e %q{"cabc""cb"-}, "a"
        e %q{"cabc""cab"-}, ""
      end
    end

    describe "*" do
      describe "Integer Integer" do
        e "2 3*", 6
        e "10 20 *", 200
        e "-5 5*", -25
      end

      describe "String Integer" do
        e %q{"foobar "3*}, "foobar foobar foobar "
      end
    end

    describe "/" do
      describe "Integer Integer" do
        e "2 3/", 0
        e "10 20 /", 0
        e "10 -2/", -5
      end
    end

    describe "%" do
      describe "Integer Integer" do
        e "2 3%", 2
        e "10 20 %", 10
        e "5 -3%", -1
      end

      describe "String Integer" do
        e %q{"%05d" 123%}, "00123"
      end

      describe "String Array" do
        e %q{"%02d %03d %04d"4#%}, "00 001 0002"
      end
    end

    describe "^" do
      describe "Integer Integer" do
        e "2 3^", 8
        e "10 20 ^", 10 ** 20
        e "-3 3^", -27
      end
    end

    describe "#" do
      describe "Integer" do
        e "3#", [0, 1, 2]
      end

      describe "String" do
        e %q{"foo bar"#}, 7
      end

      describe "Array" do
        e "10##", 10
      end
    end

    describe "$" do
      describe "String" do
        e %q{"abcdcba"$}, "aabbccd"
      end
    end

    describe "Ic" do
      describe "Integer" do
        e "97 Ic", "a"
      end
    end

    describe "Sg" do
      describe "(Integer | String) (Integer | String) (Integer | String)" do
        e %q{123 1 2 Sg}, "223"
        e %q{"123" 1 "s" Sg}, "s23"
        e %q{123 1 "s" Sg}, "s23"
        e %q{"foo bar" "f" "b" Sg}, "boo bar"
      end
    end

    describe "Sl" do
      describe "String" do
        e %q{"Foo Bar!" Sl}, "foo bar!"
      end
    end

    describe "Su" do
      describe "String" do
        e %q{"Foo Bar!" Su}, "FOO BAR!"
      end
    end

    describe "Sc" do
      describe "String" do
        e %q{"foo bar!" Sc}, "Foo bar!"
      end
    end

    describe "So" do
      describe "String" do
        e %q{"a" So}, 97
      end
    end

    describe "Si" do
      describe "(Integer | String) (Integer | String)" do
        e %q{123 11 Si}, 0
        e %q{123 "11" Si}, 0
        e %q{"foo bar" "o b" Si}, 1
        e %q{"444" 4 Si}, 1
      end
    end

    describe "Ra" do
      e "Ra", "abc\nbcd", "abc\nbcd"
    end

    describe "Rl" do
      e "Rl", "abc", "abc\nbcd"
    end
  end

  describe "Mixture" do
    e "1 2+3-", 0
    e "5 1 4 5 2 3 4 +-+-+-", 0
    e "1-2-3-+", 2
    e "1-2- 3+", 6
  end
end
