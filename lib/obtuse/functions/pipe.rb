module Obtuse
  class Evaluator
    fn :|, Integer, Integer do |x, y|
      push x > y ? x : y
    end

    fn :|, Array, Array do |x, y|
      push x | y
    end

    fn :|, Array, AST::Lambda do |x, y|
      array = x.select do |el|
        push el
        eval y.expression, true
        truthy?(pop)
      end
      push array
    end
  end
end
