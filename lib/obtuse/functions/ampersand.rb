module Obtuse
  class Evaluator
    fn :&, Integer, Integer do |x, y|
      push x > y ? y : x
    end

    fn :&, Array, Array do |x, y|
      push x & y
    end
  end
end
