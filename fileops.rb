class FileOps
  def self.read(file_name)
    file = File.open(file_name, "r")
    file_data = file.readlines.map(&:chomp)
    file.close
    return file_data
  end
end
