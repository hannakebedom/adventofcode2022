# --- Day 7: No Space Left On Device (December 7th, 2022) ---
require_relative 'fileops'

class Day7
  attr_accessor :file, :file_system
  
  def initialize(file_name)
    @file = FileOps.read(file_name)
    @file_system = { "/" => { build_file_system(@file[1..-1], ["/"], 0) } }
  end
    
  def build_file_system(file, path, parent_level)
    for i in file.length
      curr_level = file[i].length - file[i].lstrip.length
      continue if curr_level - parent_level > 2
    
      dir = file[i].end_with?('(dir)')
      name = file[i].scan(/- (.*) \(/)
      path << name
      
      if dir
        puts "dir name: #{name}"
        @file_system.dig(path)&.[] = { build_file_system(@file[1..-1], path, curr_level) }
      else
        puts "file name: #{name}" 
        # get file size too!
        @file_system.dig(path)&.[] = 0
      end
    end
  end
  
end

day7 = Day7.new('input/day7ex.txt')
puts day7.file_system
