module Obtuse
  class Evaluator
    fn :/, Integer, Integer do |x, y|
      push x / y
    end

    fn :/, String, Integer do |x, y|
      push x.chars.to_a.each_slice(y).map(&:join)
    end

    fn :/, Array, Integer do |x, y|
      push x.each_slice(y).to_a
    end
  end
end
