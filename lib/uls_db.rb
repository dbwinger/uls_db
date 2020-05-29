require File.expand_path("./uls_db/version", __dir__)
require 'pg'
require 'csv'

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

  def self.setup_db connection_options
    connection_options ||= {dbname: :fcc_uls}
    # conn = PG::Connection.open
    # conn.exec_params("DROP DATABASE IF EXISTS fcc_uls")
    # conn.exec_params("CREATE DATABASE fcc_uls")
    # conn.close
    conn = PG::Connection.open(connection_options)
    conn.exec_params(File.read File.expand_path('../db/uls_schema.sql', __dir__))
  end

  def self.import_table_to_db database, table, clear: true
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

  # Heroku DB url: postgres://rcqwixcfckljzv:79db03c9d892182a20e466cf6a4d8f9949296403b337eb0a6da87ff4a0f78db8@ec2-54-175-117-212.compute-1.amazonaws.com:5432/ddcl8dskgb3o5s
  # Or can use {dbname: :fcc_uls} for connection_options
  def self.import_all_to_db file_path, use_tables:, clear_tables: true, connection_options: 'postgres://rcqwixcfckljzv:79db03c9d892182a20e466cf6a4d8f9949296403b337eb0a6da87ff4a0f78db8@ec2-54-175-117-212.compute-1.amazonaws.com:5432/ddcl8dskgb3o5s' #{dbname: :fcc_uls}
    conn = PG::Connection.open(connection_options)
    tables = []
    rows = CSV.read(file_path, col_sep: '|')
    rows.each_with_index do |row, i|
      table = row[0]
      if use_tables && use_tables.include?(table)
        if clear_tables && !tables.include?(table)
          conn.exec_params("DELETE FROM uls_#{table}")
          puts "cleared #{table}"
        end

        tables << table

        values = row.map do |v|
          v.nil? ? 'NULL' : "'#{v.gsub("'","''")}'"
        end.join(',')
        res = conn.exec_params("INSERT INTO uls_#{table} VALUES (#{values})")
        puts "inserted row #{i} of #{rows.count} into #{table}"
      end
    end; nil
  end
end

require File.expand_path('lib/uls_db/services/aggregate_data_on_transmitter_equipment_service.rb')
