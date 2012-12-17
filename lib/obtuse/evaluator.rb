module Obtuse
  class Evaluator
    def initialize
      @stack     = []
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
