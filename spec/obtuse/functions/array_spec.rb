require "spec_helper"

describe Obtuse do
  describe "Az" do
    describe "Array Array" do
      e %q{[] [] Az}, []
      e %q{[1 2 3 4] [1 2 3 4] Az}, [[1, 1], [2, 2], [3, 3], [4, 4]]
      e %q{[1 2 3] [1 2 3 4] Az}, [[1, 1], [2, 2], [3, 3]]
      e %q{[1 2 3 4] [1 2 3] Az}, [[1, 1], [2, 2], [3, 3], [4, nil]]
    end

    describe "Array Array Lambda" do
      e %q{[] [] {+} Az}, []
      e %q{[1 2 3 4] [1 2 3 4] {+} Az}, [2, 4, 6, 8]
    end
  end
end
