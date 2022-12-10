# --- Day 9: Rope Bridge ---
require_relative 'fileops'

class Day9
  attr_accessor :file, :visited
  
  def initialize(file_name)
    @file = FileOps.read(file_name)
    @tail = [1, 1]
    @head = [1, 1]
    @visited = [[1, 1]]
    read_commands
  end
  
  def chase_head
    '''move the tail to the head if they\'re not touching'''
    right, left = [@tail[0] + 2, @tail[1]], [@tail[0] - 2, @tail[1]]
    up, down = [@tail[0], @tail[1] + 2], [@tail[0], @tail[1] - 2]
    
    if right == @head
      @tail = [@tail[0] + 1, @tail[1]]
    elsif left == @head
      @tail = [@tail[0] - 1, @tail[1]]
    elsif up == @head
      @tail = [@tail[0], @tail[1] + 1]
    elsif down == @head
      @tail = [@tail[0], @tail[1] - 1]
    else
      diagonals = [[@tail[0] + 1, @tail[1] + 1], [@tail[0] + 1, @tail[1] - 1], [@tail[0] - 1, @tail[1] + 1], [@tail[0] - 1, @tail[1] - 1]]
      distances = diagonals.map { |tail| Math.sqrt((tail[0] - @head[0])**2 + (tail[1] - @head[1])**2) }
      @tail = diagonals[distances.index(distances.min)]
    end
    @visited << @tail if !@visited.include?(@tail)
  end
  
  def touching
    '''check if the head is touching the tail'''
    return true if [[@tail[0] + 1, @tail[1]], [@tail[0] - 1, @tail[1]], [@tail[0], @tail[1] + 1], [@tail[0], @tail[1] - 1], @tail, [@tail[0] + 1, @tail[1] + 1], [@tail[0] + 1, @tail[1] - 1], [@tail[0] - 1, @tail[1] + 1], [@tail[0] - 1, @tail[1] - 1]].include?(@head)
    return false
  end
  
  def read_commands
    for line in @file
      direction, distance = line.split(' ')
      distance = distance.to_i
      
      for i in 1..distance
        if direction == 'R'
          @head[0] += 1
        elsif direction == 'L'
          @head[0] -= 1
        elsif direction == 'U'
          @head[1] += 1
        elsif direction == 'D'
          @head[1] -= 1
        end
        chase_head if !touching
      end
    end
  end
end

solution = Day9.new('input/day9.txt')
puts solution.visited.length