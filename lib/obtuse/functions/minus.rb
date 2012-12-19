module Obtuse
  class Evaluator
    fn :-, Integer, Integer do |x, y|
      push x - y
    end

    fn :-, String, String do |x, y|
      push (x.chars.to_a - y.chars.to_a).join
    end

    fn :-, Array, Object do |x, y|
      push x - Array(y)
    end
  end
end
