require './test/test_helper'
require './lib/decryptable'

class MockDecryptable
  include Decryptable

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
    '180121'
  end

  def next_after(last_shift)
    if last_shift < 3
      last_shift + 1
    else
      0
    end
  end
end

class DecryptableTest < Minitest::Test
  def setup
    @enigma = MockDecryptable.new
  end

  def test_can_decrypt_with_all_args
    expected = {
      decryption: 'hello world',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @enigma.decrypt('keder ohulw', '02715', '040895')
  end

  def test_can_decrypt_without_optional_args
    # Note, this message & key decrypted w/ date of 1/18/21 returns 'hello world'
    result = @enigma.decrypt('xsjednuhgzb', '66219')

    assert_equal 3, result.size
    assert_equal [:decryption, :key, :date], result.keys
  end

  def test_decrypt_handles_unsupported_chars
    expected = {
      decryption: 'hello world!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @enigma.decrypt('keder ohulw!', '02715', '040895')
  end

  def test_decrypts_message
    shift_rules = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal 'hello world', @enigma.do_decrypt('keder ohulw', shift_rules)
    assert_equal 'alex lee', @enigma.do_decrypt('dlxqclxy', shift_rules)
  end
end
