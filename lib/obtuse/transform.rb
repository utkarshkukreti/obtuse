module Obtuse
  class Transform < Parslet::Transform
    rule(integer: simple(:x))  { x.to_i }
    rule(function: simple(:x)) { x.to_s }
  end
end
