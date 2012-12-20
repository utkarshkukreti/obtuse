require "spec_helper"

describe Obtuse do
  describe "|" do
    describe "Integer Integer" do
      e "0 0 |", 0
      e "1 0 |", 1
      e "1 0 |", 1
      e "1 1 |", 1
      e "69 3 |", 69
    end

    describe "Array Array" do
      e %q{[1 2 "a" "b"] ["a" 1 4 "c"] |}, [1, 2, "a", "b", 4, "c"]
      e %q{[1 2 3 1 2 3] [] |}, [1, 2, 3]
      e %q{[] [] |}, []
    end

    describe "Array Lambda" do
      e %q{[1 2 3 4] {2 %}|}, [1, 3]
    end
  end
end
