require "spec_helper"

describe Obtuse do
  describe "Variables" do
    e ["1:a", "a"], [1, 1]
    e ["1 :a a + :b", "a", "b"], [2, 1, 2]
    e ["1 2 + :a :b 1 + :c 1 + :a", "a", "b", "c"], [5, 5, 3, 4]
    e ["{1+} :inc;", "5#inc%"], [nil, [1, 2, 3, 4, 5]]
  end
end
