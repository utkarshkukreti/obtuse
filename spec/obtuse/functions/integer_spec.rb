require "spec_helper"

describe Obtuse do
  describe "Ic" do
    describe "Integer" do
      e "97 Ic", "a"
    end
  end

  describe "Ir" do
    describe "(String | Integer)" do
      # No way to this with the current spec helpers.
    end
  end

  describe "Ib" do
    describe "Object Object" do
      e %q{10 2 Ib}, "1010"
      e %q{64 16 Ib}, "40"
      e %q{"10" 11 Ib}, "a"
      e %q{"90" 20 Ib}, "4a"
    end
  end
end
