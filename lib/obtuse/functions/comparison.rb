module Obtuse
  class Evaluator
    [Integer, String, Object].each do |type|
      %w{= < >}.each do |op|
        fn op, type, type do |x, y|
          op = "==" if op == "="
          push x.send(op, y) ? 1 : 0
        end
      end
    end
  end
end
