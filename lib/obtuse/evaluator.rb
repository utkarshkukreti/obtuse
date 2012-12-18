module Obtuse
  class Evaluator
    attr_accessor :stdin
    attr_reader :stack

    def initialize
      @stack     = []
      @stdin     = $stdin
      @parser    = Parser.new
      @transform = Transform.new
    end

    def eval(input)
      @transform.apply(@parser.parse(input)).each do |atom|
        case atom
        when Integer, String
          push atom
        when :+, :-, :*, :/, :%, :^
          atom = :** if atom == :^
          y, x = pop, pop
          if Integer === x && Integer === y ||
            String === x && String === y
            push x.send(atom, y)
          else
          end
        when :Ia
          push stdin.read.chomp
        when :Il
          push stdin.gets.chomp
        end
      end
    end

    def push(object)
      @stack << object
    end

    def pop
      @stack.pop
    end

    def peek
      @stack.last
    end
  end
end
