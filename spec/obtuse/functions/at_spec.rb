require "spec_helper"

describe Obtuse do
  describe "@" do
    describe "Object Object Object" do
      e %q{"abc" 10 4# @}, [10, [0, 1, 2, 3], "abc"], stack: true
    end
  end
end
