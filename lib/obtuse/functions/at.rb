module Obtuse
  class Evaluator
    fn "@", Object, Object, Object do |x, y, z|
      push y; push z; push x
    end
  end
end
