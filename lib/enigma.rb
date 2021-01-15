class Enigma
  SHIFT_KEYS = [:a, :b, :c, :d]

  def encrypt(message, key, date)
    # Need to generate a key?
    # Need to generate a date?

    # Calculate shifts
    create_shifts(key, date)

    # Encrypt the message

    # Format / return output hash
  end

  def create_shifts(key, date)
    return nil unless key.length == 5

    keys = parse_keys(key)
    offsets = parse_offsets(date)

    shifts = {}
    SHIFT_KEYS.each do |key|
      shifts[key] = keys[key] + offsets[key]
    end

    shifts
  end

  def parse_keys(input_key)
    keys = {}
    SHIFT_KEYS.each_with_index do |key, i|
      keys[key] = input_key[i..i+1].to_i
    end

    keys
  end

  def parse_offsets(date)
    raw_offset = calculate_raw_offset(date)

    offsets = {}
    SHIFT_KEYS.each_with_index do |key, i|
      offsets[key] = raw_offset[i].to_i
    end

    offsets
  end

  private

  def character_set
    @_character_set ||= (('a'..'z').to_a << ' ')
  end

  def calculate_raw_offset(date)
    date_as_number = date.strftime('%d%m%y').to_i
    squared_date_string = (date_as_number ** 2).to_s

    squared_date_string[-4..-1]
  end
end
