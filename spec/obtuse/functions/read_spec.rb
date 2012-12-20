require "spec_helper"

describe Obtuse do
  describe "Ra" do
    e "Ra", "abc\nbcd", stdin: "abc\nbcd"
  end

  describe "Rl" do
    e "Rl", "abc", stdin: "abc\nbcd"
  end
end
