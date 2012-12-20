require "spec_helper"

describe Obtuse do
  describe "/" do
    describe "Integer Integer" do
      e "2 3/", 0
      e "10 20 /", 0
      e "10 -2/", -5
    end

    describe "(String | Array) Integer" do
      e %q{"foobar foob" 3 /}, ["foo", "bar", " fo", "ob"]
      e %q{10# 3 /}, [[0, 1, 2], [3, 4, 5], [6, 7, 8], [9]]
    end
  end
end
