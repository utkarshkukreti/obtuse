module Obtuse
  class Evaluator
    fn :Ra do
      push stdin.read.chomp
    end

    fn :Rl do
      push stdin.gets.chomp
    end
  end
end
