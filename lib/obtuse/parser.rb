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

    rule :function do
      %w{+ - * / % ^ # $ ~ ! @ . ; [ ] = < > \\
          W Ic I Sg Sl Su Sc So Si St Ra Rl}.
        map { |name| str name }.reduce(:|).
        as(:function) >> spaces?
    end

    rule :lambda do
      str("{") >> spaces? >> expression.as(:expression).as(:lambda) >>
      str("}") >> spaces?
    end

    rule :expression do
      spaces? >> (integer | string | function | lambda).repeat >> spaces?
    end

    root :expression
  end
end
