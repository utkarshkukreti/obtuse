module Obtuse
  class Parser < Parslet::Parser
    rule(:spaces)  { match['\s'].repeat(1)  }
    rule(:spaces?) { spaces.maybe           }
    rule(:digit)   { match["0-9"]           }
    rule(:digits)  { match["0-9"].repeat(1) }

    rule :integer do
      digits.as(:integer) >> spaces?
    end

    rule :function do
      %w{+ - * / % ^}.map { |name| str name }.reduce(:|).
        as(:function) >> spaces?
    end

    rule :expression do
      spaces? >> (integer | function).repeat >> spaces?
    end

    root :expression
  end
end
