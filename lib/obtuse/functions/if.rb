module Obtuse
  class Evaluator
    fn :I, Object, Object, Object do |x, y, z|
      if AST::Lambda === x
        eval x.expression, true
        if truthy?(pop)
          AST::Lambda === y ? eval(y.expression, true) : push(y)
        else
          AST::Lambda === z ? eval(z.expression, true) : push(z)
        end
      else
        if truthy?(x)
          AST::Lambda === y ? eval(y.expression, true) : push(y)
        else
          AST::Lambda === z ? eval(z.expression, true) : push(z)
        end
      end
    end
  end
end
