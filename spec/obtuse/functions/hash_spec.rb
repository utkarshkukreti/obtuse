require "spec_helper"

describe Obtuse do
  describe "#" do
    describe "Integer" do
      e "3#", [0, 1, 2]
    end

    describe "String" do
      e %q{"foo bar"#}, 7
    end

    describe "Array" do
      e "10##", 10
      e "[1 2]#", 2
    end
  end
end
