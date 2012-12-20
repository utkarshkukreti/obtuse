require "spec_helper"

describe Obtuse do
  describe "/" do
    describe "Integer Integer" do
      e "2 3/", 0
      e "10 20 /", 0
      e "10 -2/", -5
    end
  end
end
