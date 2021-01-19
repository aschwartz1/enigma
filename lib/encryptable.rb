module Encryptable
  def encrypt(message, key=nil, date_string=nil)
    # Need to generate a key?
    key = generate_key unless key
    date_string = date_string_for(Time.now) unless date_string
    message.downcase!

    # Calculate shifts
    shift_rules = create_shifts(key, date_string)

    # Encrypt the message
    encrypted = do_encrypt(message, shift_rules)

    # Format / return output hash
    encryption_data(encrypted, key, date_string)
  end

  def do_encrypt(message, shift_rules)
    encodings = calculate_encodings(shift_rules)

    shift_index = -1
    message.chars.map do |char|
      shift_index = next_after(shift_index)
      encrypt_character(char, shift_index, encodings)
    end.join('')
  end

  def calculate_encodings(shift_rules)
    encodings = {}
    character_set.each_with_index do |char, index|
      encodings[char] = encodings_for(index, shift_rules)
    end

    encodings
  end

  # :nocov:
  def create_shifts(raw_key, date_string)
    raise NotImplementedError
  end

  def parse_keys(raw_key)
    raise NotImplementedError
  end

  def parse_offsets(date_string)
    raise NotImplementedError
  end

  def character_set
    raise NotImplementedError
  end

  def generate_key
    raise NotImplementedError
  end

  def calculate_raw_offset(date_string)
    raise NotImplementedError
  end

  def date_string_for(date)
    raise NotImplementedError
  end

  def next_after(last_shift)
    raise NotImplementedError
  end
  # :nocov:

  private

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

  def encrypt_character(char, shift_index, encodings)
    if character_set.include?(char)
      encodings[char][shift_index]
    else
      char
    end
  end

  def encryption_data(encrypted_message, key, date_string)
    {
      encryption: encrypted_message,
      key: key,
      date: date_string
    }
  end
end
