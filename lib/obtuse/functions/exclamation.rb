module Obtuse
  class Evaluator
    fn :!, Object do |x|
      push truthy?(x) ? 0 : 1
    end
  end
end
