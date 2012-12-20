require "spec_helper"

describe Obtuse do
  describe "$" do
    describe "Integer" do
      e %q{5 $}, [], stack: true
      e %q{1 0 $}, [1, 1], stack: true
      e %q{5#~ 3 $}, [0, 1, 2, 3, 4, 1], stack: true
    end

    describe "String" do
      e %q{"abcdcba"$}, "aabbccd"
    end

    describe "Array" do
      e %q{[1 4 3] $}, [1, 3, 4]
    end

    describe "(String | Array) Lambda (Sort by)" do
      e %q{"abca" {.} $}, "aabc"
      e %q{[1 4 3] {-1 *} $}, [4, 3, 1]
    end
  end
end
