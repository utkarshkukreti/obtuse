require "spec_helper"

describe Obtuse do
  describe "^" do
    describe "Integer Integer" do
      e "2 3^", 8
      e "10 20 ^", 10 ** 20
      e "-3 3^", -27
    end
  end
end
