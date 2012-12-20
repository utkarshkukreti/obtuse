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
    stdout = options[:stdout]

    it "should evaluate `#{input}` to `#{output}`" do
      evaluator = Obtuse::Evaluator.new
      evaluator.stdin = stdin
      evaluator.stdout = StringIO.new

      if !(Array === input)
        input = [input]
        output = [output]
      end

      input.zip(output).each do |input, output|
        evaluator.eval(input)
        if options[:stack]
          evaluator.stack.should eq output
        else
          evaluator.peek.should eq output
        end
      end

      if stdout
        evaluator.stdout.rewind
        evaluator.stdout.read.should eq stdout
      end
    end
  end
end
