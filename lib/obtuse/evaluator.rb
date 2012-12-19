module Obtuse
  class Evaluator
    attr_accessor :stdin
    attr_reader :stack, :marks

    def initialize
      @stack     = []
      @marks     = []
      @functions = Hash.new {|h, k| h[k] = [] }
      @stdin     = $stdin
      @parser    = Parser.new
      @transform = Transform.new


      fn "[" do
        @marks << @stack.size
      end

      fn "]" do
        mark = @marks.pop
        array = @stack.slice!(mark..-1)
        push array if array
      end

      fn ".", Object do |x|
        if x
          push x; push x;
        end
      end

      fn :+, Integer, Integer do |x, y|
        push x + y
      end

      fn :+, String, Integer do |x, y|
        push x + y.to_s
      end

      fn :+, String, String do |x, y|
        push x + y
      end

      fn :+, Array, Object do |x, y|
        push x + Array(y)
      end

      fn :-, Integer, Integer do |x, y|
        push x - y
      end

      fn :-, String, String do |x, y|
        push (x.chars.to_a - y.chars.to_a).join
      end

      fn :-, Array, Object do |x, y|
        push x - Array(y)
      end

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

      fn :/, Integer, Integer do |x, y|
        push x / y
      end

      fn :%, Integer, Integer do |x, y|
        push x % y
      end

      fn :%, String, Integer do |x, y|
        push x % y
      end

      fn :%, String, Array do |x, y|
        push x % y
      end

      fn :%, String, AST::Lambda do |x, y|
        stack = @stack
        @stack = []
        x.chars.to_a.each do |el|
          push el
          eval y.expression, true
        end
        array = @stack
        @stack = stack
        push array
      end

      fn :%, Array, AST::Lambda do |x, y|
        stack = @stack
        @stack = []
        x.each do |el|
          push el
          eval y.expression, true
        end
        array = @stack
        @stack = stack
        push array
      end

      fn :^, Integer, Integer do |x, y|
        push x ** y
      end

      fn "#", Integer do |x|
        p x
        push [*0...x]
      end

      fn "#", String do |x|
        push x.length
      end

      fn "#", Array do |x|
        push x.size
      end

      fn "$", Integer do |x|
        push @stack[-x - 1] if @stack[-x - 1]
      end

      fn "$", String do |x|
        push x.chars.sort.join
      end

      fn "$", Array do |x|
        push x.sort
      end

      fn "$", String, AST::Lambda do |x, y|
        stack = @stack
        @stack = []
        array = x.chars.to_a
        array.sort_by! do |el|
          @stack = []
          push el
          eval y.expression, true
          @stack
        end
        @stack = stack
        push array.join
      end

      fn "$", Array, AST::Lambda do |x, y|
        stack = @stack
        @stack = []
        array = x
        array.sort_by! do |el|
          @stack = []
          push el
          eval y.expression, true
          @stack
        end
        @stack = stack
        push array
      end

      fn :~, String do |x|
        eval x
      end

      fn :~, Array do |x|
        @stack += x
      end

      fn :~, AST::Lambda do |x|
        eval x.expression, true
      end

      fn :!, Object do |x|
        push truthy?(x) ? 0 : 1
      end

      fn "@", Object, Object, Object do |x, y, z|
        push y; push z; push x
      end

      fn ";", Object do |x|
      end

      [Integer, String, Object].each do |type|
        %w{= < >}.each do |op|
          fn op, type, type do |x, y|
            op = "==" if op == "="
            push x.send(op, y) ? 1 : 0
          end
        end
      end

      fn "\\", Object, Object do |x, y|
        push y; push x
      end

      fn :|, Integer, Integer do |x, y|
        push x | y
      end

      fn :&, Integer, Integer do |x, y|
        push x & y
      end

      fn :I, Object, Object, Object do |x, y, z|
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
      end

      fn :W, Object, Object do |x, y|
        if AST::Lambda === x && AST::Lambda === y
          loop do
            eval x.expression, true
            break unless truthy?(pop)
            eval y.expression, true
          end
        end
      end

      fn :Ic, Integer do |x|
        push x.chr
      end

      # This could be done in a better way.
      fn :Sg, Object, Object, Object do |x, y, z|
        push x.to_s.gsub(y.to_s, z.to_s)
      end

      fn :Sl, String do |x|
        push x.downcase
      end

      fn :Su, String do |x|
        push x.upcase
      end

      fn :Sc, String do |x|
        push x.capitalize
      end

      fn :So, String do |x|
        push x.ord
      end

      fn :Si, Object, Object do |x, y|
        push x.to_s.include?(y.to_s) ? 1 : 0
      end

      # This could also be done in a better way.
      fn :St, Object, Object, Object do |x, y, z|
        push x.to_s.tr(y.to_s, z.to_s)
      end

      fn :Ra do
        push stdin.read.chomp
      end

      fn :Rl do
        push stdin.gets.chomp
      end

      fn :Ti, Object do |x|
        push x.to_i
      end

      fn :Ts, Object do |x|
        push x.to_s
      end
    end

    def fn(name, *types, &block)
      @functions[name.to_s] << { types: types, block: block }
    end

    def eval(input, parsed = false)
      if parsed == false
        input = @transform.apply(@parser.parse(input))
      end

      return if input.nil?

      input.each do |atom|
        if Symbol === atom
          fn = @functions[atom.to_s].find do |fn|
            types = fn[:types]
            @stack.last(types.size).zip(types).all? do |x, y|
              y === x
            end
          end

          if fn
            fn[:block].call *pop(fn[:types].size)
          else
            raise ArgumentError.new "Function `#{atom}` does not match" +
              " preceding" +
              " arguments.\nLast #{[7, @stack.size].min} elements of the" +
              " stack have classes: " + @stack.last(7).map(&:class).inspect
          end
        else
          push atom
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

    def truthy?(x)
      !(x.nil? || x == 0 || x == "" || x == [])
    end
  end
end
