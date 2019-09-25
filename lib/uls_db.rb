require File.expand_path("./uls_db/version", __dir__)
require 'pg'

module UlsDb
  ROOT_DIR = File.expand_path('../', __dir__)

  def self.database_table_file_path database, table
    File.expand_path("../uls_db_input/#{database}/#{table}.dat", ROOT_DIR)
  end

  def self.output_file_path name
    File.expand_path("../uls_db_output/#{name}.tsv", ROOT_DIR)
  end

  def self.process_table database, table
    puts "Processing #{database}.#{table}...\n"

    filename = UlsDb.database_table_file_path(database, table)
    lines = %x{wc -l #{filename}}.split.first.to_i

    File.readlines(filename).each_with_index do |row, i|
      # Increments of 1k
      if i / 1000 == i / 1000.0
        print "\rProcessed #{i / 1000}k of #{lines / 1000}k rows"
      end

      fields = row[0..-1].split('|')
      yield fields
    end
  end

  def self.setup_db
    conn = PG::Connection.open
    conn.exec_params("DROP DATABASE IF EXISTS fcc_uls")
    conn.exec_params("CREATE DATABASE fcc_uls")
    conn.close
    conn = PG::Connection.open(dbname: :fcc_uls)
    conn.exec_params(File.read File.expand_path('../db/schema.sql', __dir__))
  end

  def self.import_table_to_db database, table, clear = true
    filename = UlsDb.database_table_file_path(database, table)
    lines = %x{wc -l #{filename}}.split.first.to_i

    conn = PG::Connection.open(dbname: :fcc_uls)
    conn.exec_params "DELETE FROM uls_#{table}" if clear


    File.readlines(filename).each_with_index do |row, i|
      # Increments of 1k
      if i / 1000 == i / 1000.0
        print "\rProcessed #{i / 1000}k of #{lines / 1000}k rows"
      end

      values = row[0..-1].split('|').map { |v| "'#{v}'" }.join(',')
      res = conn.exec_params("INSERT INTO uls_#{table} VALUES (#{values})")
    end
  end
end

require File.expand_path('lib/uls_db/services/aggregate_data_on_transmitter_equipment_service.rb')