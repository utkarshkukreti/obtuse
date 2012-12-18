module Obtuse
  module AST
    class Lambda
      attr_accessor :expression

      def initialize(expression)
        @expression = expression
      end
    end
  end
end
