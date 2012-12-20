module Obtuse
  class Evaluator
    fn "[" do
      @marks << @stack.size
    end

    fn "]" do
      mark = @marks.pop || 0
      array = @stack.slice!(mark..-1)
      push array if array
    end

    fn ".", Object do |x|
      if x
        push x; push x;
      end
    end

    fn ";", Object do |x|
    end
  end
end
