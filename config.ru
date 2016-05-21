require "redis"
Dir["#{File.expand_path("./lib")}/**/**"].each { |filename| require(filename) }

run Popsicle::Application.new
