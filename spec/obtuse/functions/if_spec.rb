require "spec_helper"

describe Obtuse do
  describe "I" do
    describe "Object Object Object" do
      e '0 1 2 I', 2
      e '1 1 2 I', 1
      e '0 1 {...} {.}I', [0, 0, 0, 0], stack: true
      e '1 {} 1 I', nil
      e '0 {} {} I', nil
    end
  end
end
