require "logger"

module Popsicle
  class Application
    include ActiveSupport::Configurable
    attr_accessor :request
    config_accessor :store
    config_accessor :app_name
    config_accessor :headers
    config_accessor :index_key

    def initialize
      super
      apply_config!
    end

    def call(env)
      @request = Rack::Request.new(env)
      begin
        response(code: 200, body: found_revision)
      rescue => e
        logger.error(e)
        response(code: 500, body: e.class.to_s)
      end
    end

    def found_revision
      store.get(revision_key).to_s
    end

    def store
      config[:store]
    end

    def app_name
      config[:app_name]
    end

    def headers
      config[:headers]
    end

    def index_key
      config[:index_key]
    end

    def revision_requested?
      request.params.key?(index_key)
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def revision_key
      if revision_requested?
        "#{app_name}:index:#{request.params[index_key]}"
      else
        current_revision_value = store.get("#{app_name}:index:current")
        "#{app_name}:index:#{current_revision_value}"
      end
    end

    def response(code:, body:)
      [
        code,
        headers,
        StringIO.new(body)
      ]
    end

    private

    def apply_config!
      config[:app_name] ||= ENV["POPSICLE_APP_NAME"]
      config[:index_key] ||= ENV["POPSICLE_INDEX_KEY"]

      return if config[:store]
      require "redis"
      config[:store] ||= Redis.new(host: ENV["POPSICLE_REDIS_HOST"],
                                     port: ENV["POPSICLE_REDIS_PORT"],
                                     password: ENV["POPSICLE_REDIS_PASSWORD"],
                                     timeout: ENV["POPSICLE_REDIS_TIMEOUT"],
                                     reconnect_attempts: ENV["POPSICLE_REDIS_RECONNECT_ATTEMPTS"],
                                     role: ENV["POPSICLE_REDIS_ROLE"])
    end
  end
end
