module Obtuse
  class Evaluator
    [Integer, String, Object].each do |type|
      fn :>, type, type do |x, y|
        push x > y ? 1 : 0
      end
    end
  end
end
