module Obtuse
  class Evaluator
    attr_accessor :stdin
    attr_reader :stack

    def initialize
      @stack     = []
      @stdin     = $stdin
      @parser    = Parser.new
      @transform = Transform.new
    end

    def eval(input)
      @transform.apply(@parser.parse(input)).each do |atom|
        case atom
        when Integer, String
          push atom
        when :+, :-, :*, :/, :%, :^
          atom = :** if atom == :^
          y, x = pop, pop
          if Integer === x && Integer === y
            push x.send(atom, y)
          elsif String === x && String === y
            case atom
            when :+
              push x + y
            when :-
              push (x.chars.to_a - y.chars.to_a).join
            end
          elsif String === x && Integer === y
            case atom
            when :+
              push x + y.to_s
            when :*
              push x * y
            when :%
              push x % y
            end
          elsif String === x && Array === y
            case atom
            when :%
              push x % y
            end
          else
          end
        when :"#"
          x = pop
          if Integer === x
            push [*0...x]
          elsif String === x || Array === x
            push x.length
          end
        when :"$"
          x = pop
          if String === x
            push x.chars.sort.join
          end
        when :Sg
          z, y, x = pop, pop, pop
          if (Integer === x || String === x) &&
             (Integer === y || String === y) &&
             (Integer === z || String === z)
            push x.to_s.gsub(y.to_s, z.to_s)
          end
        when :Sl
          push pop.to_s.downcase
        when :Su
          push pop.to_s.upcase
        when :Sc
          push pop.to_s.capitalize
        when :Ra
          push stdin.read.chomp
        when :Rl
          push stdin.gets.chomp
        end
      end
    end

    def push(object)
      @stack << object
    end

    def pop
      @stack.pop
    end

    def peek
      @stack.last
    end
  end
end
