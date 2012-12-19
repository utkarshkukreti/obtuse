module Obtuse
  class Evaluator
    fn :W, Object, Object do |x, y|
      if AST::Lambda === x && AST::Lambda === y
        loop do
          eval x.expression, true
          break unless truthy?(pop)
          eval y.expression, true
        end
      end
    end
  end
end
