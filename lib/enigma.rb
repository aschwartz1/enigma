class Enigma
  SHIFT_KEYS = [:a, :b, :c, :d]

  def encrypt(message, key, date)
    # Need to generate a key?
    # Need to generate a date?

    # Calculate offset

    # Calculate shifts

    # Encrypt the message

    # Format / return output hash
  end

  def create_shifts(key, date)
    return nil unless key.length == 5

    keys = parse_keys(key)
    offsets = offsets_from_date(date)
  end

  def parse_keys(input_key)
    keys = {}
    SHIFT_KEYS.each_with_index do |key, i|
      keys[key] = input_key[i..i+1].to_i
    end

    keys
  end

  def parse_offsets(date)
    date_as_number = date.strftime('%d%m%y').to_i
    squared_date_string = (date_as_number ** 2).to_s
    raw_offset = squared_date_string[-4..-1]

    offsets = {}
    SHIFT_KEYS.each_with_index do |key, i|
      offsets[key] = raw_offset[i].to_i
    end

    offsets
  end
end
