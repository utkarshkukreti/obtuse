module Obtuse
  module AST
    class Deassignment
      attr_accessor :variable

      def initialize(variable)
        @variable = variable
      end
    end
  end
end
