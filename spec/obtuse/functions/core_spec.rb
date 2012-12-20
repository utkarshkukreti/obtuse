require "spec_helper"

describe Obtuse do
  describe "." do
    describe "" do
      e %q{1 2 .}, [1, 2, 2], stack: true
      e %q{.}, [], stack: true
    end
  end

  describe ";" do
    describe "" do
      e %q{1 2;}, [1], stack: true
      e %q{2;}, [], stack: true
      e %q{;}, [], stack: true
    end
  end

  describe "[]" do
    e %q{[1 . 2 . + . [1 . .]]}, [1, 1, 4, 4, [1, 1, 1]]
    e "1[..]", [1, [1, 1]], stack: true
    e "1 2]", [1, 2]
    e "1] 2] 3] 4]", [[[[1], 2], 3], 4]
  end
end
