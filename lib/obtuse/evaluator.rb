module Obtuse
  class Evaluator
    attr_accessor :stdin
    attr_reader :stack, :stash

    def initialize
      @stack     = []
      @stash     = []
      @stdin     = $stdin
      @parser    = Parser.new
      @transform = Transform.new
    end

    def eval(input, parsed = false)
      if parsed == false
        input = @transform.apply(@parser.parse(input))
      end

      input.each do |atom|
        case atom
        when Integer, String, Array, AST::Lambda
          push atom
        when :+, :-, :*, :/, :%, :^
          atom = :** if atom == :^
          x, y = pop 2
          if Integer === x && Integer === y
            push x.send(atom, y)
          elsif String === x && Integer === y
            case atom
            when :+
              push x + y.to_s
            when :*
              push x * y
            when :%
              push x % y
            end
          elsif String === x && String === y
            case atom
            when :+
              push x + y
            when :-
              push (x.chars.to_a - y.chars.to_a).join
            when :*
              push x.chars.to_a.join(y)
            end
          elsif String === x && Array === y
            case atom
            when :%
              push x % y
            end
          elsif Array === x
            case atom
            when :+
              push x + Array(y)
            when :-
              push x - Array(y)
            when :*
              if Integer === y
                push x * y
              elsif String === y
                push x.join(y)
              elsif Array === y
                first = x.shift
                push x.reduce([first]) {|fold, el| fold + y + [el] }
              elsif AST::Lambda === y
                push x.shift
                x.each do |el|
                  push el
                  eval y.expression, true
                end
              end
            when :%
              if AST::Lambda === y
                stash
                x.each do |el|
                  push el
                  eval y.expression, true
                end
                stack = @stack
                unstash
                push stack
              end
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
          if Integer === x
            push @stack[-x - 1] if @stack[-x - 1]
          elsif String === x
            push x.chars.sort.join
          elsif Array === x
            push x.sort
          elsif AST::Lambda === x
            y = x
            x = pop
            case x
            when String, Array
              stash
              array = String === x ? x.chars.to_a : x
              array.sort_by! do |el|
                @stack = []
                push el
                eval y.expression, true
                @stack
              end
              unstash
              push String === x ? array.join : array
            end
          end
        when :~
          x = pop
          case x
          when String
            eval x
          when Array
            @stack += x
          when AST::Lambda
            eval x.expression, true
          end
        when :!
          push truthy?(pop) ? 0 : 1
        when :"@"
          x, y, z = pop 3
          push y; push z; push x
        when :"."
          x = peek
          push x if x
        when :";"
          pop
        when :"["
          stash
        when :"]"
          stack = @stack
          unstash
          push stack
        when :"=", :<, :>
          atom = :== if atom == :"="
          x, y = pop 2
          if Integer === x && Integer === y ||
              String === x && String === y ||
               Array === x && Array === y
            push x.send(atom, y) ? 1 : 0
          end
        when :I
          x, y, z = pop 3
          if AST::Lambda === x
            eval x.expression, true
            if truthy?(pop)
              AST::Lambda === y ? eval(y.expression, true) : push(y)
            else
              AST::Lambda === z ? eval(z.expression, true) : push(z)
            end
          else
            if truthy?(x)
              AST::Lambda === y ? eval(y.expression, true) : push(y)
            else
              AST::Lambda === z ? eval(z.expression, true) : push(z)
            end
          end
        when :W
          x, y = pop 2
          if AST::Lambda === x && AST::Lambda === y
            loop do
              eval x.expression, true
              break unless truthy?(pop)
              eval y.expression, true
            end
          end
        when :Ic
          push pop.to_i.chr
        when :Sg
          x, y, z = pop 3
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
        when :So
          push pop.to_s.ord
        when :Si
          x, y = pop 2
          push x.to_s.include?(y.to_s) ? 1 : 0
        when :St
          x, y, z = pop 3
          push x.to_s.tr(y.to_s, z.to_s)
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

    def pop(n = nil)
      n ? @stack.pop(n) : @stack.pop
    end

    def peek
      @stack.last
    end

    def stash
      @stash << @stack
      @stack = []
    end

    def unstash
      @stack = @stash.pop
    end

    def truthy?(x)
      !(x.nil? || x == 0 || x == "" || x == [])
    end
  end
end
