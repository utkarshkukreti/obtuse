require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Libraries", "/lib"
end
require "obtuse"

RSpec.configure do |config|
  def e(input, output, stdin = $stdin)
    if String === stdin
      stdin = StringIO.new(stdin)
    end
    it "should evaluate #{input.inspect} to #{output.inspect}" do
      evaluator = Obtuse::Evaluator.new
      evaluator.stdin = stdin
      evaluator.eval(input)
      evaluator.peek.should eq output
    end
  end
end
