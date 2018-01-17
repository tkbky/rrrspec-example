require 'fileutils'

env = ENV["RRRSPEC_ENV"] || "development"
db_config = YAML.load(ERB.new(File.read("database.yml")).result)

ActiveRecord::Base.default_timezone = :local

RRRSpec.configure do |conf|
  conf.redis = {
    host: ENV['REDIS_HOST']
  }
end

%i(server web).each do |type|
  RRRSpec.configure(type) do |config|
    config.persistence_db = db_config[env].symbolize_keys
    config.execute_log_text_path = "/tmp/rrrspec-log-texts"
  end
end

RRRSpec.configure(:server) do |config|
  config.pidfile = "tmp/pids/rrrspec-master.pid"
end
