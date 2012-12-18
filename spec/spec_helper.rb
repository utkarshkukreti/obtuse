require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Libraries", "/lib"
end
require "obtuse"

RSpec.configure do |config|
  def e(input, output, stdin = $stdin)
    stdin = StringIO.new(stdin) if String === stdin

    it "should evaluate `#{input}` to `#{output}`" do
      evaluator = Obtuse::Evaluator.new
      evaluator.stdin = stdin
      evaluator.eval(input)
      evaluator.peek.should eq output
    end
  end
end
