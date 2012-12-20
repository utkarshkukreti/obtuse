module Obtuse
  class Evaluator
    fn :Az, Array, Array do |x, y|
      push x.zip(y)
    end

    fn :Az, Array, Array, AST::Lambda do |x, y, z|
      array = []
      mark = @stack.size
      array = x.zip(y).map do |x, y|
        push x; push y;
        eval z.expression, true
      end
      push @stack.slice!(mark..-1)
    end
  end
end
