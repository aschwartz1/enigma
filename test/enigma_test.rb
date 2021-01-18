require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
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
end
