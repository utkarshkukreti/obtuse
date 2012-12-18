module Obtuse
  class Transform < Parslet::Transform
    rule(integer:  simple(:x)) { x.to_i        }
    rule(function: simple(:x)) { x.to_s.to_sym }
    rule(string:   simple(:x)) do
      x.to_s.gsub('\\t', "\t").gsub('\\n', "\n").gsub('\\"', '"')
    end
    rule(array: sequence(:x)) { x }
  end
end
