require "logger"

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
        [200, headers, StringIO.new(found_revision)]
      rescue => e
        logger.error(e)
        [500, headers, StringIO.new(e.class.to_s)]
      end
    end

    def found_revision
      (store.get("#{index_key}:#{request.params[index_key]}") || default_revision).to_s
    end

    def default_revision
      key = store.get("#{index_key}:current")
      store.get("#{index_key}:#{key}")
    end

    def revision_requested?
      request.params.key?(index_key)
    end

    def logger
      @logger ||= Logger.new(build_log_file)
    end

    private

    def build_log_file
      File.expand_path(".", "log/#{ENV["RACK_ENV"]}.log").tap do |filename|
        File.new(filename, "w")
      end
    end
  end
end
