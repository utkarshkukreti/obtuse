module Obtuse
  class Parser < Parslet::Parser
    rule(:spaces)  { match['\s'].repeat(1)  }
    rule(:spaces?) { spaces.maybe           }
    rule(:digit)   { match["0-9"]           }
    rule(:digits)  { match["0-9"].repeat(1) }
    rule(:minus)   { str("-")               }

    rule :integer do
      (minus.maybe >> digits).as(:integer) >> spaces?
    end

    rule :string do
      str('"') >> (str('"').absent? >> (str('\\"') | any)).repeat.as(:string) >>
      str('"') >> spaces?
    end

    rule :array do
      str("[") >> spaces? >> (integer | string).repeat.as(:array) >> spaces? >>
      str("]") >> spaces?
    end

    rule :function do
      %w{+ - * / % ^ # $ ~ ! @ Ic Sg Sl Su Sc So Si St Ra Rl}.
        map { |name| str name }.reduce(:|).
        as(:function) >> spaces?
    end

    rule :expression do
      spaces? >> (array | string | integer | function).repeat >> spaces?
    end

    root :expression
  end
end
