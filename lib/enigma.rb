require './lib/encryptable'

class Enigma
  include Encryptable

  SHIFT_KEYS = [:a, :b, :c, :d]

  def create_shifts(raw_key, date_string)
    keys = parse_keys(raw_key)
    offsets = parse_offsets(date_string)

    shifts = {}
    SHIFT_KEYS.each do |key|
      shifts[key] = keys[key] + offsets[key]
    end

    shifts
  end

  def parse_keys(raw_key)
    keys = {}
    SHIFT_KEYS.each_with_index do |key, i|
      keys[key] = raw_key[i..i+1].to_i
    end

    keys
  end

  def parse_offsets(date_string)
    raw_offset = calculate_raw_offset(date_string)

    offsets = {}
    SHIFT_KEYS.each_with_index do |key, i|
      offsets[key] = raw_offset[i].to_i
    end

    offsets
  end

  ### --- ENCRYPT --- ###

  # def encrypt(message, key=nil, date_string=nil)
  #   # Need to generate a key?
  #   key = generate_key unless key
  #   date_string = date_string_for(Time.now) unless date_string
  #   message.downcase!

  #   # Calculate shifts
  #   shift_rules = create_shifts(key, date_string)

  #   # Encrypt the message
  #   encrypted = do_encrypt(message, shift_rules)

  #   # Format / return output hash
  #   encryption_data(encrypted, key, date_string)
  # end

  # def do_encrypt(message, shift_rules)
  #   encodings = calculate_encodings(shift_rules)

  #   shift_index = -1
  #   message.chars.map do |char|
  #     shift_index = next_after(shift_index)
  #     encrypt_character(char, shift_index, encodings)
  #   end.join('')
  # end

  # def calculate_encodings(shift_rules)
  #   encodings = {}
  #   character_set.each_with_index do |char, index|
  #     encodings[char] = encodings_for(index, shift_rules)
  #   end

  #   encodings
  # end

  ### --- END ENCRYPT --- ###

  ### --- DECRYPT --- ###

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

  ### --- END DECRYPT --- ###

  private

  def character_set
    @_character_set ||= (('a'..'z').to_a << ' ')
  end

  def generate_key
    rand(0..99999).to_s.rjust(5, '0')
  end

  def calculate_raw_offset(date_string)
    (date_string.to_i ** 2).to_s[-4..-1]
  end

  def date_string_for(date)
    date.strftime('%d%m%y')
  end

  def next_after(last_shift)
    if last_shift < 3
      last_shift + 1
    else
      0
    end
  end

  ### --- ENCRYPT --- ###

  # def encodings_for(orig_index, shift_rules)
  #   encodings = []
  #   shift_rules.keys.sort.each do |shift|
  #     encodings << encoding_for(orig_index, shift_rules[shift])
  #   end

  #   encodings
  # end

  # def encoding_for(orig_index, shift)
  #   num_characters = character_set.length
  #   new_index = (orig_index + (shift % num_characters)) % num_characters

  #   character_set[new_index]
  # end

  # def encrypt_character(char, shift_index, encodings)
  #   if character_set.include?(char)
  #     encodings[char][shift_index]
  #   else
  #     char
  #   end
  # end

  # def encryption_data(encrypted_message, key, date_string)
  #   {
  #     encryption: encrypted_message,
  #     key: key,
  #     date: date_string
  #   }
  # end

  ### --- END ENCRYPT --- ###

  ### --- DECRYPT --- ###

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

  ### --- END DECRYPT --- ###
end
