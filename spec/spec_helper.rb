require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Libraries", "/lib"
end
require "obtuse"

RSpec.configure do |config|
  def e(input, output)
    it "should evaluate #{input.inspect} to #{output.inspect}" do
      evaluator = Obtuse::Evaluator.new
      evaluator.eval(input)
      evaluator.peek.should eq output
    end
  end
end
