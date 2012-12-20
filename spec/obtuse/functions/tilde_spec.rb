require "spec_helper"

describe Obtuse do
  describe "~" do
    describe "String" do
      e %q{"123"~}, 123
      e %q{"1 2 3 + -"~}, -4
    end

    describe "Array" do
      e %q{4#~+++}, 6
      e %q{[1 2]~+}, 3
    end

    describe "Lambda" do
      e '{1 1 +}~', 2
    end
  end
end
