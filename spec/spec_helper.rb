require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group  "Libraries", "/lib"
  add_filter "/lib/obtuse/cli.rb"
end
require "obtuse"

RSpec.configure do |config|
  def e(input, output, options = {})
    stdin = options[:stdin]
    stdin = String === stdin ? StringIO.new(stdin) : $stdin

    it "should evaluate `#{input}` to `#{output}`" do
      evaluator = Obtuse::Evaluator.new
      evaluator.stdin = stdin
      evaluator.eval(input)
      if options[:stack]
        evaluator.stack.should eq output
      else
        evaluator.peek.should eq output
      end
    end
  end
end
