require "spec_helper"

describe Obtuse do
  describe "&" do
    describe "Integer Integer" do
      e "0 0 &", 0
      e "1 0 &", 0
      e "1 0 &", 0
      e "1 1 &", 1
      e "69 4 &", 4
      e "3 4 &", 3
    end

    describe "Array Array" do
      e %q{[1 2 "a" "b"] ["a" 1 4 "c"] &}, [1, "a"]
      e %q{[1 2 3 1 2 3] [] &}, []
      e %q{[1 2 3 1 2 3] . &}, [1, 2, 3]
      e %q{[] [] &}, []
    end
  end
end
