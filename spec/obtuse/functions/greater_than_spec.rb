require "spec_helper"

describe Obtuse do
  describe ">" do
    describe "Object Object" do
      e %q{5 3 >}, 1
      e %q{"bar" "foo" >}, 0
    end
  end
end
