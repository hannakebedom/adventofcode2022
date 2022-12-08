# --- Day 7: No Space Left On Device (December 7th, 2022) ---
require_relative 'fileops'

class Day7
  attr_accessor :file, :file_system, :dir_sizes
  
  def initialize(file_name)
    @file = FileOps.read(file_name)
    @file_system = {"/" => {}}
    @dir_sizes = {}
    read_commands
  end
    
  def read_commands
    current_dir = @file_system["/"]
    prev_dir = ["/"] # stack
    
    for line in @file do
      if line.start_with?("$ cd")
        target = line.split(' ')[-1]
        puts "$ cd #{target}"
        puts current_dir
        if target == '/'
          prev_dir = ["/"]
          current_dir = @file_system["/"]
        elsif target == '..'
          prev_dir.pop
          current_dir = @file_system.dig(*prev_dir)
        else
          prev_dir.push(target)
          current_dir = current_dir[target]
        end
      elsif line.start_with?("$ ls")
        puts "$ ls"
        puts current_dir
        next
      else
        type, name = line.split(' ')
        if type == "dir"
          puts "dir #{name}"
          puts current_dir
          current_dir[name] = { } if !current_dir.key?(name)
        else
          puts "#{type} #{name}"
          puts current_dir
          current_dir[name] = type.to_i if !current_dir.key?(name)
        end
      end
    end
  end
  
  def size(hash, path)
    size = 0
    hash.each do |key, value|
      if value.is_a?(Hash)
        dir_size = size(value, path)
        path << "#{key}/" if key != "/"
        @dir_sizes[path] = dir_size
        size += dir_size
      else
        size += value
      end
    end
    # @dir_sizes["/"] = size
    return size
  end
  
  def sum_directories
    sum = 0
    @dir_sizes.each do |key, value|
      sum += value if value <= 100000
    end
    return sum
  end
end

day7 = Day7.new('input/day7.txt')
puts day7.size(day7.file_system["/"], "/")
puts day7.dir_sizes
puts day7.sum_directories
