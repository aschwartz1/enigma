require './lib/encryptable'
require './lib/decryptable'

class Enigma
  include Encryptable
  include Decryptable

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
end
