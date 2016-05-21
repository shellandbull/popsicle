require "logger"

module Popsicle
  class Application
    include ActiveSupport::Configurable
    attr_accessor :request
    config_accessor :store
    config_accessor :app_name
    config_accessor :headers
    config_accessor :index_key

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
      @_config[:store]
    end

    def app_name
      @_config[:app_name]
    end

    def headers
      @_config[:headers]
    end

    def index_key
      @_config[:index_key]
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
  end
end
