module Obtuse
  class Evaluator
    fn :+, Integer, Integer do |x, y|
      push x + y
    end

    fn :+, String, Integer do |x, y|
      push x + y.to_s
    end

    fn :+, String, String do |x, y|
      push x + y
    end

    fn :+, Array, Object do |x, y|
      push x + Array(y)
    end
  end
end
