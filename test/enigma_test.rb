require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_can_encrypt_with_all_args
    skip
    key = '02715'
    date = Date.new(1995, 8, 4)

    expected = {
      encryption: 'keder ohulw',
      key: key,
      date: '04081995'
    }

    assert_equal expected, @enigma.encrypt('hello world', key, date)
  end

  def test_can_encrypt_without_optional_args
    skip
  end

  def test_ecryption_ignores_chars
    skip
    key = '02715'
    date = Date.new(1995, 8, 4)

    expected = {
      encryption: 'keder ohulw!',
      key: key,
      date: '04081995'
    }

    assert_equal expected, @enigma.encrypt('HELLO world!', key, date)
  end

  def test_parse_keys
    expected = {
      a: 2,
      b: 27,
      c: 71,
      d: 15
    }

    assert_equal expected, @enigma.parse_keys('02715')
  end

  def test_parse_shifts
    skip
  end

  def test_can_create_shifts
    skip
    expected = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }
    key = '02715'
    date = Date.new(1995, 8, 4)

    assert_equal expected, @enigma.find_shifts(key, date)
  end
end
