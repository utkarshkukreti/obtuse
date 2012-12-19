require "spec_helper"

describe Obtuse do
  describe "GCD" do
    # From http://www.golfscript.com/golfscript/examples.html
    e '13483 74205 {.}{.@\%}W;', 13483.gcd(74205)
  end

  describe "LCM" do
    e '13483 74205 .@.@{.}{.@\%}W;\@*\/', 13483.lcm(74205)
  end

  describe "Hailstone Sequence (Collatz Conjecture)" do
    e '13[.{.1>}{{.2%}{.3*1+}{.2/}I}W]', [13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
  end

  describe "Project Euler" do
    describe "Problem #6: Find the difference between the sum of the squares" +
      " of the first one hundred natural numbers and the square of the sum." do
      e '101#{+}*2^101#{2^}%{+}*-', 25164150
    end

    describe "Problem #16: Sum of digits of 2 ^ 1000" do
      e '2 1000^Ts{Ti}%{+}*', 1366
    end
  end
end
