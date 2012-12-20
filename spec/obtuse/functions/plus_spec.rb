require "spec_helper"

describe Obtuse do
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

    describe "Array Object" do
      e %q{[1 2] 1 +}, [1, 2, 1]
      e %q{[1 2] "1" +}, [1, 2, "1"]
      e %q{[1] [] +}, [1]
      e %q{[1 2] [3 4] +}, [1, 2, 3, 4]
    end
  end
end
