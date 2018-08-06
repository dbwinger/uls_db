require "uls_db/version"

module UlsDb
  ROOT_DIR = File.expand_path('../', __dir__)

  def self.database_table_file_path database, table
    File.expand_path("~/Downloads/TEMP/uls_db/#{database}/#{table}.dat")
  end

  def self.output_file_path name
    File.expand_path("~/Downloads/TEMP/uls_db/output/#{name}.tsv")
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
end

require File.expand_path('lib/uls_db/services/aggregate_data_on_transmitter_equipment_service.rb')