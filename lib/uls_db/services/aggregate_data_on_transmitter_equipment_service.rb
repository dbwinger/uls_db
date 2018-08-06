# Pulls rows from FR table for Transmitters matching the make and model by regex, and aggregates data from other tables
class AggregateDataOnTransmitterEquipmentService

  def self.perform make_regex, model_regex
    data = {}

    UlsDb.process_table(:l_micro, :FR) do |fields|
      call_sign = fields[4]

      if fields[21].match?(make_regex) && fields[22].match?(model_regex)
        # If we already have data on this call sign, add the equipment and location numbers (keeping one hash entry/row in output file)
        if data.key? call_sign
          data[call_sign][:equipment] = data[call_sign][:equipment] + ",#{fields[21]} #{fields[22]}"
          data[call_sign][:location_numbers] = data[call_sign][:location_numbers] + ",#{fields[6]}"
        else # Add the entry
          data[call_sign] = { call_sign: call_sign, equipment: "#{fields[21]} #{fields[22]}", location_numbers: fields[6] }
        end
      end
    end

    puts "\nFound #{data.count} frequencies."
    puts "Removing inactive..."

    deleted = 0
    
    UlsDb.process_table(:l_micro, :HD) do |fields|
      call_sign = fields[4]

      # Remove from results data if the call sign is not active
      if data.keys.include?(call_sign) && (fields[5] != 'A')
        data.delete(call_sign)
        deleted = deleted + 1
      end
    end

    puts "\nRemoved #{deleted}"

    UlsDb.process_table(:l_micro, :EN) do |fields|
      call_sign = fields[4]

      if data.keys.include? call_sign
        # There are records of type 'L' and 'CL' for most or all. Collect both
        type = fields[5].downcase
        data[call_sign].merge!(
          {
            "#{type}_entity": fields[7],
            "#{type}_first_name": fields[8],
            "#{type}_last_name": fields[10],
            "#{type}_phone": fields[12],
            "#{type}_email": fields[14],
            "#{type}_address": fields[15],
            "#{type}_city": fields[16],
            "#{type}_state": fields[17],
            "#{type}_zip": fields[18],
            "#{type}_po_box": fields[19],
          }
        )
      end
    end

    UlsDb.process_table(:l_micro, :LO) do |fields|
      call_sign = fields[4]

      # Only get records for the location number(s) specified in the FR record
      if data.keys.include?(call_sign) && data[call_sign][:location_numbers].split(',').include?(fields[8])
        data[call_sign].merge!(
          {
            location_address: fields[11],
            location_city: fields[12],
            location_state: fields[14],
            latitude: "#{fields[19]}° #{fields[20]}' #{fields[21]}\"",
            latitude_direction: fields[22],
            longitude: "#{fields[23]}° #{fields[24]}' #{fields[25]}\"",
            longitude_direction: fields[26]
          }
        )
      end
    end

    puts "\nWriting output file..."

    File.open(UlsDb.output_file_path('aggregated_data_on_frequencies_with_transmitter_equipment'), 'w') do |output|
      # Header row
      fields = %w(call_sign equipment l_entity l_first_name l_last_name l_phone l_email l_address l_city l_state l_zip l_po_box cl_entity cl_first_name cl_last_name cl_phone cl_email cl_address cl_city cl_state cl_zip cl_po_box location_address location_city location_state latitude latitude_direction longitude longitude_direction)
      output.write fields.join("\t") + "\n"

      data.values.map do |row|
        output.write fields.map { |field| row[field.to_sym] }.join("\t") + "\n"
      end
    end

    puts "Done."

    data
  end

end