module Obtuse
  class Evaluator
    fn :%, Integer, Integer do |x, y|
      push x % y
    end

    fn :%, String, Integer do |x, y|
      push x % y
    end

    fn :%, String, Array do |x, y|
      push x % y
    end

    fn :%, String, AST::Lambda do |x, y|
      stack = @stack
      @stack = []
      x.chars.to_a.each do |el|
        push el
        eval y.expression, true
      end
      array = @stack
      @stack = stack
      push array
    end

    fn :%, Array, AST::Lambda do |x, y|
      stack = @stack
      @stack = []
      x.each do |el|
        push el
        eval y.expression, true
      end
      array = @stack
      @stack = stack
      push array
    end
  end
end
