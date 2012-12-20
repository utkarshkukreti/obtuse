require "spec_helper"

describe Obtuse do
  describe "\\" do
    describe "Object Object" do
      e %q{1 2 \\}, [2, 1], stack: true
      e %q{[] [1] \\}, [[1], []], stack: true
    end
  end
end
