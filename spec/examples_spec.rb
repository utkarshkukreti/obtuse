require "spec_helper"

describe Obtuse do
  describe "GCD" do
    # From http://www.golfscript.com/golfscript/examples.html
    e '13483 74205 {.}{.@\%}W;', 13483.gcd(74205)
  end

  describe "LCM" do
    e '13483 74205 .@.@{.}{.@\%}W;\@*\/', 13483.lcm(74205)
  end

  describe "Project Euler" do
    describe "Problem #6: Find the difference between the sum of the squares" +
      " of the first one hundred natural numbers and the square of the sum." do
      e '101#{+}*2^101#{2^}%{+}*-', 25164150
    end
  end
end
