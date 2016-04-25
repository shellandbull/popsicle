require "mock_redis"
require "rack/test"
require "pry"

Dir["#{File.expand_path("./lib")}/**/**"].each { |filename| require(filename) }


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Rack::Test::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
