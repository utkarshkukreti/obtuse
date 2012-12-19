module Obtuse
  class Evaluator
    fn "$", Integer do |x|
      push @stack[-x - 1] if @stack[-x - 1]
    end

    fn "$", String do |x|
      push x.chars.sort.join
    end

    fn "$", Array do |x|
      push x.sort
    end

    fn "$", String, AST::Lambda do |x, y|
      stack = @stack
      @stack = []
      array = x.chars.to_a
      array.sort_by! do |el|
        @stack = []
        push el
        eval y.expression, true
        @stack
      end
      @stack = stack
      push array.join
    end

    fn "$", Array, AST::Lambda do |x, y|
      stack = @stack
      @stack = []
      array = x
      array.sort_by! do |el|
        @stack = []
        push el
        eval y.expression, true
        @stack
      end
      @stack = stack
      push array
    end
  end
end
