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
      str('"') >> ((str('"').absent? >> (str('\\"') | any)).repeat(1)).maybe.
        as(:string) >> str('"') >> spaces?
    end

    rule :function do
      %w{+ - * / % ^ # $ ~ ! @ . ; [ ] = < > \\ | &
          Wl W Ic Ir Ib I Sg Sl Su Sc So Si St Sr Ra Rl Ti Ts}.
        map { |name| str name }.reduce(:|).
        as(:function) >> spaces?
    end

    rule :lambda do
      str("{") >> spaces? >> expression.as(:expression).as(:lambda) >>
      str("}") >> spaces?
    end

    rule :variable do
      match["a-zA-Z_"].repeat(1).as(:variable) >> spaces?
    end

    rule :assignment do
      str(":") >> spaces? >> variable.as(:assignment)
    end

    rule :deassignment do
      variable.as(:deassignment)
    end

    rule :expression do
      spaces? >>
        (assignment | integer | string | function | lambda | deassignment).
        repeat(1) >> spaces? |
      spaces?
    end

    root :expression
  end
end
