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
  end
end
