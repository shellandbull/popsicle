require "logger"
require "pry"

module Popsicle
  class Application
    attr_accessor :request, :store, :app_name, :headers, :index_key

    def initialize(store:, app_name:, headers:, index_key:)
      @store     = store
      @app_name  = app_name
      @headers   = headers
      @index_key = index_key
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

    def revision_requested?
      request.params.key?(index_key)
    end

    def logger
      @logger ||= Logger.new(build_log_file)
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

    def build_log_file
      File.expand_path(".", "log/#{ENV["RACK_ENV"]}.log").tap do |filename|
        File.new(filename, "w")
      end
    end
  end
end
