module Decryptable
  def decrypt(message, key, date_string=nil)
    date_string = date_string_for(Time.now) unless date_string
    message.downcase!

    # Calculate shifts
    shift_rules = create_shifts(key, date_string)

    # Decrypt the message
    decrypted = do_decrypt(message, shift_rules)

    # Format / return output hash
    decryption_data(decrypted, key, date_string)
  end

  def do_decrypt(encryption, shift_rules)
    decodings = calculate_decodings(shift_rules)

    shift_index = -1
    encryption.chars.map do |char|
      shift_index = next_after(shift_index)
      decrypt_character(char, shift_index, decodings)
    end.join('')
  end

  def calculate_decodings(shift_rules)
    decodings = {}
    character_set.each_with_index do |char, index|
      decodings[char] = decodings_for(index, shift_rules)
    end

    decodings
  end

  private

  def decodings_for(encoded_index, shift_rules)
    decodings = []
    shift_rules.keys.sort.each do |shift|
      decodings << decoding_for(encoded_index, shift_rules[shift])
    end

    decodings
  end

  def decoding_for(encoded_index, shift)
    num_characters = character_set.length
    orig_index = (encoded_index - (shift % num_characters)) % num_characters

    character_set[orig_index]
  end

  def decrypt_character(char, shift_index, decodings)
    if character_set.include?(char)
      decodings[char][shift_index]
    else
      char
    end
  end

  def decryption_data(decrypted_message, key, date_string)
    {
      decryption: decrypted_message,
      key: key,
      date: date_string
    }
  end
end
