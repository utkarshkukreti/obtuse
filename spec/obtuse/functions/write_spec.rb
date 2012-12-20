require "spec_helper"

describe Obtuse do
  describe "Wl" do
    describe "Object" do
      e "10 Wl", nil, stdout: "10\n"
      e %q{"10" Wl}, nil, stdout: "10\n"
      e %q{[1 2 3] Wl}, nil, stdout: "1\n2\n3\n"
    end
  end
end
