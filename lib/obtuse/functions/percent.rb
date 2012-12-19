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
      array = []
      mark = @stack.size
      x.chars.to_a.each do |el|
        push el
        eval y.expression, true
        array += @stack.slice!(mark..-1) || []
      end
      push array
    end

    fn :%, Array, AST::Lambda do |x, y|
      array = []
      mark = @stack.size
      x.each do |el|
        push el
        eval y.expression, true
        array += @stack.slice!(mark..-1) || []
      end
      push array
    end
  end
end
