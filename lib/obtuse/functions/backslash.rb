module Obtuse
  class Evaluator
    fn "\\", Object, Object do |x, y|
      push y; push x
    end
  end
end
