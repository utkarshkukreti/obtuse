require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Libraries", "/lib"
end
require "obtuse"

RSpec.configure do |config|
end
