class FileHelper
  def read(filepath)
    begin
      file = File.open(filepath, 'r')
      data = file.read.chomp
    ensure
      file.close
    end

    data
  end

  def write(contents, filepath)
    begin
      file = File.open(filepath, 'w')
      file.write(contents)
    ensure
      file.close
    end
  end

  def file_exists?(filepath)
    File.exist?(filepath)
  end
end
