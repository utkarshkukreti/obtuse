module Obtuse
  class Evaluator
    fn "#", Integer do |x|
      push [*0...x]
    end

    fn "#", String do |x|
      push x.length
    end

    fn "#", Array do |x|
      push x.size
    end
  end
end
