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

  def test_can_write_file
    message_to_write = 'The quick brown fox jumps over the lazy dog'

    begin
      @helper.write(message_to_write, 'tmp.txt')
      message_read_back_in = @helper.read('tmp.txt')

      assert_equal message_to_write, message_read_back_in
    ensure
      File.delete('tmp.txt') if File.exist? 'tmp.txt'
    end
  end
end
