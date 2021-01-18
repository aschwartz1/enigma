require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  ### --- ENIGMA --- ###

  def test_parse_keys
    expected = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }

    assert_equal expected, @enigma.parse_keys('02715')
  end

  def test_parse_offsets
    expected = {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }

    assert_equal expected, @enigma.parse_offsets('040895')
  end

  def test_can_create_shifts
    expected = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal expected, @enigma.create_shifts('02715', '040895')
  end

  ### --- END ENIGMA -- ###

  ### --- ENCRYPT --- ###

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
      encryption: 'keder ohulw',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @enigma.encrypt('HELLO WORLD', '02715', '040895')
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

  ### --- END ENCRYPT --- ###

  ### --- DECRYPT --- ###

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

  ### --- END DECRYPT --- ###
end
