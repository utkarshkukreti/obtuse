module Obtuse
  module AST
    class Assignment
      attr_accessor :variable

      def initialize(variable)
        @variable = variable
      end
    end
  end
end
