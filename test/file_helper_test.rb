require './test/test_helper'
require './lib/file_helper'

class FileHelperTest < Minitest::Test
  def setup
    @helper = FileHelper.new
  end

  def test_if_exists
    assert_instance_of FileHelper, @helper
  end

  def test_can_check_file_exists
    assert_equal false, @helper.file_exists?('./test/fixtures/does_not_exist.txt')
  end

  def test_can_read_file
    message = @helper.read('./test/fixtures/hello_world.txt')

    assert_equal 'hello world', message
  end
end
