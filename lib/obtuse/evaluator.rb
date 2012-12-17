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
        when Integer
          push atom
        when "+", "-", "*", "/", "%", "^"
          atom = "**" if atom == "^"
          y, x = pop, pop
          push x.send(atom, y)
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
