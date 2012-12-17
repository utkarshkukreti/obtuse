require "spec_helper"

describe Obtuse do
  it "should have a VERSION" do
    Obtuse::VERSION.should be_a String
  end

  describe "+, -, *, /, % and ^ on 2 integers" do
    e "2 1+", 3
    e "10 20 +", 30
    e "2 3-", -1
    e "10 20 -", -10
    e "2 3*", 6
    e "10 20 *", 200
    e "2 3/", 0
    e "10 20 /", 0
    e "2 3%", 2
    e "10 20 %", 10
    e "2 3^", 8
    e "10 20 ^", 10 ** 20

    e "1 2+3-", 0
    e "5 1 4 5 2 3 4 +-+-+-", 0
  end
end
