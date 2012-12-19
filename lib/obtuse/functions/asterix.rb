module Obtuse
  class Evaluator
    fn :*, Integer, Integer do |x, y|
      push x * y
    end

    fn :*, String, Integer do |x, y|
      push x * y
    end

    fn :*, String, String do |x, y|
      push x.chars.to_a.join(y)
    end

    fn :*, Array, Integer do |x, y|
      push x * y
    end

    fn :*, Array, String do |x, y|
      push x.join(y)
    end

    fn :*, Array, Array do |x, y|
      first = x.shift
      push x.reduce([first]) {|fold, el| fold + y + [el]}
    end

    fn :*, Array, AST::Lambda do |x, y|
      push x.shift
      x.each do |el|
        push el
        eval y.expression, true
      end
    end
  end
end
