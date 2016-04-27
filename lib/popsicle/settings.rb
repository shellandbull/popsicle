require "erb"
require "yaml"

module Popsicle
  class Settings
    attr_reader :filename, :values

    def initialize(filename: File.expand_path(".", "settings.sample.yml.erb"))
      fail ArgumentError, "#{filename} does not exist" unless File.exist?(filename)
      @filename = filename
    end

    def load
      @values = YAML.load(ERB.new(File.read(filename)).result)
    end

    def [](key)
      @values.fetch(key)
    end
  end
end
