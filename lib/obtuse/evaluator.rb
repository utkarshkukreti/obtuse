module Obtuse
  class Evaluator
    class << self
      attr_accessor :functions
    end
    @functions = Hash.new {|h, k| h[k] = [] }

    def self.fn(name, *types, &block)
      @functions[name.to_s] << { types: types, block: block }
    end

    attr_accessor :stdin
    attr_reader :stack, :marks

    def initialize
      @stack     = []
      @marks     = []
      @stdin     = $stdin
      @parser    = Parser.new
      @transform = Transform.new
    end

    def eval(input, parsed = false)
      if parsed == false
        input = @transform.apply(@parser.parse(input))
      end

      return if input.nil?

      input.each do |atom|
        if Symbol === atom
          fn = self.class.functions[atom.to_s].find do |fn|
            types = fn[:types]
            @stack.last(types.size).zip(types).all? do |x, y|
              y === x
            end
          end

          if fn
            instance_exec *pop(fn[:types].size), &fn[:block]
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
