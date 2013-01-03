ENV['RACK_ENV'] ||= "development"

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development, :test, ENV['RACK_ENV'].to_sym)

require "./config/boot"

require 'rspec/core'
require 'rspec/core/rake_task'
desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

DB_CONFIG = YAML.load_file('config/database.yml')[ENV['RACK_ENV']]

namespace :db do

  desc 'create the database'
  task :create do
    ActiveRecord::Base.establish_connection DB_CONFIG.merge('database' => nil)
    ActiveRecord::Base.connection.create_database DB_CONFIG['database']
    ActiveRecord::Base.establish_connection DB_CONFIG
  end

  desc "migrate your database"
  task :migrate do
    ActiveRecord::Base.establish_connection DB_CONFIG
    ActiveRecord::Migrator.migrate(
      'db/migrate',
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end

  desc 'drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection DB_CONFIG
    ActiveRecord::Base.connection.drop_database DB_CONFIG["database"] rescue nil
  end

  desc 'seed data'
  task :seed do
    ActiveRecord::Base.establish_connection DB_CONFIG
    seed_file = './db/seed.rb'
    load(seed_file) if seed_file
  end

  namespace :doc do
    desc 'generate html'
    task :html do
      mysql_to_html = './script/mysql_to_html.rb'
      load(mysql_to_html) if mysql_to_html
    end

    desc 'generate csv'
    task :csv do
      mysql_to_csv = './script/mysql_to_csv.rb'
      load(mysql_to_csv) if mysql_to_csv
    end
  end

  namespace :structure do
    desc "Dump the database structure to a SQL file"
    task :dump do
      ActiveRecord::Base.establish_connection(DB_CONFIG)
      db_path = './db'
      mkdir db_path unless File.exists? db_path
      File.open(File.join(db_path, "#{ENV['RACK_ENV']}_structure.sql"), 'w+') { |f| f << ActiveRecord::Base.connection.structure_dump }
    end
  end

  namespace :schema do
    desc 'Create a db/schema.rb file that can be portably used against any DB supported by AR'
    task :dump do
      ActiveRecord::Base.establish_connection DB_CONFIG
      require 'active_record/schema_dumper'
      filename = ENV['SCHEMA'] || "./db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end

end