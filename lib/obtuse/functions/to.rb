module Obtuse
  class Evaluator
    fn :Ti, Object do |x|
      push x.to_i
    end

    fn :Ts, Object do |x|
      push x.to_s
    end
  end
end
