class Enigma
  def encrypt(message, key, date)
    # Need to generate a key?
    # Need to generate a date?

    # Calculate offset

    # Calculate shifts

    # Encrypt the message

    # Format / return output hash
  end

  def parse_shifts(key, date)
    return nil unless key.length == 5

    keys = parse_keys(key)

    offsets = offsets_from_date(date)
  end

  def parse_keys(input_key)
    keys_keys = [:a, :b, :c, :d]

    keys = {}
    keys_keys.each_with_index do |key, i|
      keys[key] = input_key[i..i+1].to_i
    end

    keys
  end
end
