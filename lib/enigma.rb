class Enigma
  SHIFT_KEYS = [:a, :b, :c, :d]

  def encrypt(message, key, date)
    # Need to generate a key?
    # Need to generate a date?

    # Calculate shifts
    shift_rules = create_shifts(key, date)

    # Encrypt the message
    do_encrypt(message, shift_rules)

    # Format / return output hash
  end

  def do_encrypt(message, shift_rules)

  end

  def mapping_table(shift_rules)
    mapping_table = {}
    character_set.each_with_index do |char, index|
      mapping_table[char] = new_indexes_for(index, shift_rules)
    end

    mapping_table
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

  def new_indexes_for(orig_index, shift_rules)
    positions = []
    shift_rules.keys.sort.each do |shift|
      positions << shift_formula(orig_index, shift_rules[shift])
    end

    positions
  end

  def shift_formula(orig_index, shift)
    num_characters = character_set.length
    (orig_index + (shift % num_characters)) % num_characters
  end
end
