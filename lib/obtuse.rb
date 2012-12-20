require "parslet"

require "obtuse/ast/lambda"
require "obtuse/ast/assignment"
require "obtuse/ast/deassignment"

require "obtuse/parser"
require "obtuse/transform"
require "obtuse/evaluator"

Dir[File.dirname(__FILE__) + "/obtuse/functions/*.rb"].each do |file|
  require file
end

require "obtuse/cli"

require "obtuse/version"
