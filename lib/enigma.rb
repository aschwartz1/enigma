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
    encodings = calculate_encodings(shift_rules)

    encrypted_message = ''
    current_shift = 0
    message.chars.each do |char|
      encrypted_message << encodings[char][which_shift]
      current_shift = next_shift(current_shift)
    end
  end

  def calculate_encodings(shift_rules)
    encodings = {}
    character_set.each_with_index do |char, index|
      encodings[char] = encodings_for(index, shift_rules)
    end

    encodings
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

  def encodings_for(orig_index, shift_rules)
    encodings = []
    shift_rules.keys.sort.each do |shift|
      encodings << encoding_for(orig_index, shift_rules[shift])
    end

    encodings
  end

  def encoding_for(orig_index, shift)
    num_characters = character_set.length
    new_index = (orig_index + (shift % num_characters)) % num_characters

    character_set[new_index]
  end

  def next_shift(current_shift)
    if current_shift < 4
      current_shift + 1
    else
      0
    end
  end
end
