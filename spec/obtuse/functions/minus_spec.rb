require "spec_helper"

describe Obtuse do
  describe "-" do
    describe "Integer Integer" do
      e "2 3-", -1
      e "10 20 -", -10
      e "-10 -20-", 10
    end

    describe "String String" do
      e %q{"aaa""a"-}, ""
      e %q{"cabc""b"-}, "cac"
      e %q{"cabc""cb"-}, "a"
      e %q{"cabc""cab"-}, ""
    end

    describe "Array Object" do
      e %q{[1 2] 1 -}, [2]
      e %q{[1 2] "1" -}, [1, 2]
      e %q{[1] [] -}, [1]
      e %q{[1 2 3 3 1 4 4] [3 4] -}, [1, 2, 1]
    end
  end
end
