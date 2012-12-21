require "spec_helper"

describe Obtuse do
  describe "=" do
    describe "Integer Integer" do
      e %q{12 12 =}, 1
    end

    describe "String String" do
      e %q{"foo" "foo " =}, 0
    end

    describe "Array Array" do
      e %q{5# [0 1 2 3 4] =}, 1
    end
  end
end
