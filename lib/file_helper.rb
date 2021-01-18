class FileHelper
  def read(filepath)
    file = File.open(filepath, 'r')

    file.read.chomp
  end

  def file_exists?(filepath)
    File.exist?(filepath)
  end
end
