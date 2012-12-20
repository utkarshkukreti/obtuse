require "spec_helper"

describe Obtuse do
  describe "=" do
    describe "Object Object" do
      e %q{12 12 =}, 1
      e %q{"foo" "foo " =}, 0
    end
  end
end
