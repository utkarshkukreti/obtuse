require "spec_helper"

describe Obtuse do
  describe "%" do
    describe "Integer Integer" do
      e "2 3%", 2
      e "10 20 %", 10
      e "5 -3%", -1
    end

    describe "String Integer" do
      e %q{"%05d" 123%}, "00123"
    end

    describe "String Array" do
      e %q{"%02d %03d %04d"4#%}, "00 001 0002"
      e %q{"%02d %03d %04d"[0 1 2 3 4 5]%}, "00 001 0002"
    end

    describe "String Lambda (Map)" do
      e %q{"1 2 3 4" {So} %}, [49, 32, 50, 32, 51, 32, 52]
      e %q{"123" . {1$\;} %}, ["123", "123", "123"]
    end

    describe "Array Lambda (Map)" do
      e %q{[1 2 3 4] {..} %}, [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4]
      e %q{[1 2 3] . {1$\;} %}, [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
    end
  end
end
