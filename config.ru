require "redis"
Dir["#{File.expand_path("./lib")}/**/**"].each { |filename| require(filename) }

filename       = File.expand_path(".", "settings.yml.erb")

unless File.exist?(filename)
  system("cp settings.sample.yml.erb #{filename}")
end

settings       = Popsicle::Settings.new(filename: filename)
settings.load
settings       = settings.fetch("popsicle")
store_settings = settings.fetch("store").fetch("redis")

store = Redis.new(host:               store_settings["host"],
                  port:               store_settings["port"],
                  password:           store_settings["password"],
                  timeout:            store_settings["timeout"],
                  reconnect_attempts: store_settings["reconnect_attempts"],
                  role:               store_settings["role"])

application = Popsicle::Application.new(store: store,
                                        app_name: settings["app_name"],
                                        headers: settings["headers"],
                                        index_key: settings["index_key"])

run application
