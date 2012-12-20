require "spec_helper"

describe Obtuse do
  describe "*" do
    describe "Integer Integer" do
      e "2 3*", 6
      e "10 20 *", 200
      e "-5 5*", -25
    end

    describe "(String | Array) Integer" do
      e %q{"foobar "3*}, "foobar foobar foobar "
      e %q{[1 2 3] 3*}, [1, 2, 3, 1, 2, 3, 1, 2, 3]
    end

    describe "String String" do
      e %q{"foobar" " 3 "*}, "f 3 o 3 o 3 b 3 a 3 r"
    end

    describe "Array String" do
      e %q{[1 2 3] ", "*}, "1, 2, 3"
      e %q{[1 . 3] ", "*}, "1, 1, 3"
    end

    describe "Array Array" do
      e %q{[1 2 3] [1] *}, [1, 1, 2, 1, 3]
      e %q{[1 2 3] [0 1] *}, [1, 0, 1, 2, 0, 1, 3]
    end

    describe "Array Lambda (Fold)" do
      e %q{[1 2 3] {+} *}, 6
      e %q{[1 2 3] {-} *}, -4
    end

    describe "Lambda Integer" do
      e %q{2 {2 *} 5 *}, 64
    end
  end
end
