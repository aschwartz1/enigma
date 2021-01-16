require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  # TODO: once actual encrypt method works
  # def test_can_encrypt_with_all_args
  #   skip
  #   expected = {
  #     encryption: 'keder ohulw',
  #     key: key,
  #     date: '04081995'
  #   }

  #   assert_equal expected, @enigma.encrypt('hello world', '02715', Date.new(1995, 8, 4))
  # end

  # TODO: once encryption w/ args works
  # def test_can_encrypt_without_optional_args
  # end

  # TODO: once everything's done, I think
  # def test_ecryption_ignores_chars
  #   skip
  #   key = '02715'
  #   date = Date.new(1995, 8, 4)

  #   expected = {
  #     encryption: 'keder ohulw!',
  #     key: key,
  #     date: '04081995'
  #   }

  #   assert_equal expected, @enigma.encrypt('HELLO world!', key, date)
  # end

  def test_create_mapping_table
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

  def test_actual_encryption
    skip
    shift_rules = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal 'keder ohulw', @enigma.do_encrypt('hello world', shift_rules)
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

  def test_parse_offsets
    expected = {
      a: 1,
      b: 0,
      c: 2,
      d: 5
    }

    assert_equal expected, @enigma.parse_offsets(Date.new(1995, 8, 4))
  end

  def test_can_create_shifts
    expected = {
      a: 3,
      b: 27,
      c: 73,
      d: 20
    }

    assert_equal expected, @enigma.create_shifts('02715', Date.new(1995, 8, 4))
  end
end
