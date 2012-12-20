module Obtuse
  class Evaluator
    fn :Ic, Integer do |x|
      push x.chr
    end

    fn :Ir, Integer do |x|
      push rand(x == 0 ? 2 ** 32 : x)
    end

    fn :Ir, String do |x|
      push rand(x.to_i == 0 ? 2 ** 32 : x.to_i)
    end

    fn :Ib, Integer, Integer do |x, y|
      push x.to_s(y)
    end

    fn :Ib, String, Integer do |x, y|
      push x.to_i.to_s(y)
    end
  end
end
