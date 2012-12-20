require "spec_helper"

describe Obtuse do
  describe "W" do
    describe "Lambda Lambda" do
      e '3{.}{1-}W', 0
      e '5{.}{1-.}W', [4, 3, 2, 1, 0, 0], stack: true
    end
  end
end
