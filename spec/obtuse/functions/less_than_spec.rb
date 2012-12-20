require "spec_helper"

describe Obtuse do
  describe "<" do
    describe "Object Object" do
      e %q{5 3 <}, 0
      e %q{"bar" "foo" <}, 1
    end
  end
end
