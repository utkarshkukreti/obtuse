require "spec_helper"

describe Obtuse do
  describe "!" do
    describe "" do
      e "!", 1
    end

    describe "Integer" do
      e "1!", 0
      e "0!", 1
    end

    describe "String" do
      e %q{""!}, 1
      e %q{"foo"!}, 0
    end

    describe "Array" do
      e "1#!", 0
      e "0#!", 1
      e "[]!", 1
      e "[1]!", 0
    end
  end
end
