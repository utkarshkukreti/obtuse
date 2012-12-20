require "spec_helper"

describe Obtuse do
  describe "Ti" do
    e %q{1 Ti}, 1
    e %q{"1" Ti}, 1
    e %q{"foo" Ti}, 0
  end

  describe "Ts" do
    e %q{1 Ts}, "1"
    e %q{"foo" Ts}, "foo"
  end
end
