module Obtuse
  class Evaluator
    fn :~, String do |x|
      eval x
    end

    fn :~, Array do |x|
      @stack += x
    end

    fn :~, AST::Lambda do |x|
      eval x.expression, true
    end
  end
end
