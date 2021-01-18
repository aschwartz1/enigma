require './test/test_helper'
require './lib/encryptable'

class MockEncryptable
  include Encryptable

  def create_shifts(raw_key, date_string)
    {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }
  end

  def parse_keys(raw_key)
    {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }
  end

  def parse_offsets(date_string)
    {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }
  end

  def character_set
    @_character_set ||= (('a'..'z').to_a << ' ')
  end

  def generate_key
    # rand(0..99999).to_s.rjust(5, '0')
    '02175'
  end

  def calculate_raw_offset(date_string)
    # (date_string.to_i ** 2).to_s[-4..-1]
    '1025'
  end

  def date_string_for(date)
    # date.strftime('%d%m%y')
  end

  def next_after(last_shift)
    if last_shift < 3
      last_shift + 1
    else
      0
    end
  end
end

class EncryptableTest < Minitest::Test
  def setup
    @enigma = MockEncryptable.new
  end

  def test_it_exists
    assert_instance_of MockEncryptable, @enigma
  end

  def test_can_encrypt_with_all_args
    expected = {
      encryption: 'keder ohulw',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @enigma.encrypt('hello world', '02715', '040895')
  end

  def test_can_encrypt_without_optional_args
    result = @enigma.encrypt('hello world')

    assert_equal 3, result.size
    assert_equal [:encryption, :key, :date], result.keys
  end

  def test_encrypt_handles_unsupported_chars
    expected = {
      encryption: 'keder ohulw!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @enigma.encrypt('HELLO WORLD!', '02715', '040895')
  end

  def test_create_encrypt_encodings
    shift_rules = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    result = @enigma.calculate_encodings(shift_rules)

    assert_equal ['e', 'b', 'u', 'v'], result['b']
    assert_equal ['o', 'l', 'd', 'e'], result['l']
    assert_equal ['a', 'y', 'q', 'r'], result['y']
  end

  def test_encrypts_message
    shift_rules = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal 'keder ohulw', @enigma.do_encrypt('hello world', shift_rules)
    assert_equal 'dlxqclxy', @enigma.do_encrypt('alex lee', shift_rules)
  end
end
