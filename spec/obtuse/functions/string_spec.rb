require "spec_helper"

describe Obtuse do
  describe "Sg" do
    describe "(Integer | String) (Integer | String) (Integer | String)" do
      e %q{123 1 2 Sg}, "223"
      e %q{"123" 1 "s" Sg}, "s23"
      e %q{123 1 "s" Sg}, "s23"
      e %q{"foo bar" "f" "b" Sg}, "boo bar"
    end
  end

  describe "Sl" do
    describe "String" do
      e %q{"Foo Bar!" Sl}, "foo bar!"
    end
  end

  describe "Su" do
    describe "String" do
      e %q{"Foo Bar!" Su}, "FOO BAR!"
    end
  end

  describe "Sc" do
    describe "String" do
      e %q{"foo bar!" Sc}, "Foo bar!"
    end
  end

  describe "So" do
    describe "String" do
      e %q{"a" So}, 97
    end
  end

  describe "Si" do
    describe "(Integer | String) (Integer | String)" do
      e %q{123 11 Si}, 0
      e %q{123 "11" Si}, 0
      e %q{"foo bar" "o b" Si}, 1
      e %q{"444" 4 Si}, 1
    end
  end

  describe "St" do
    describe "(Integer | String) (Integer | String) (Integer | String)" do
      e %q{123 13 98 St}, "928"
      e %q{"123" "13" 98 St}, "928"
      e %q{"hello" "a-y" "b-z" St}, "ifmmp"
      e %q{"hello" "^aeiou" 0 St}, "0e00o"
    end
  end

  describe "Sr" do
    describe "String" do
      e %q{"foo " Sr}, " oof"
      e %q{"foo bar" Sr}, "rab oof"""
    end
  end
end
