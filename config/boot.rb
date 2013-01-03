APP_CONFIG = YAML.load_file('config/app_config.yml')[ENV['RACK_ENV']]

db_config = YAML::load_file('config/database.yml')[ENV['RACK_ENV']]
ActiveRecord::Base.establish_connection db_config

load_list = ["initializers", "../app/models", "../app/controllers", "../app"]

load_list.each do |dir|
  Dir[File.expand_path("../#{dir}/*.rb", __FILE__)].each do |file|
    require file
  end
end