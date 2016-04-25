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
        [200, headers, found_revision]
      rescue => e
        [500, headers, e.class.to_s]
      end
    end

    def found_revision
      store.get("#{index_key}:#{request.params[index_key]}") || default_revision
    end

    def default_revision
      key = store.get("#{index_key}:current")
      store.get("#{index_key}:#{key}")
    end

    def revision_requested?
      request.params.key?(index_key)
    end
  end
end
