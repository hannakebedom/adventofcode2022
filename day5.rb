# DAY 5: Supply Stacks (December 5th, 2022)
require_relative 'fileops'

file = FileOps.read('input/day5.txt')

stacks = Array.new(9) { Array.new }
directions = []

def populate(stacks, file, directions)
  for line in file do
    if line[0] != "m" && line[1] != "1"
      index = 0
      for i in (4..line.length+1).step(4) do
        box = line[i-4...i]
        stacks[index].unshift(box[1]) if box[1] != " "
        index += 1
      end
    elsif line[1] != "1"
      nums = line.scan(/\d+/).map(&:to_i)
      directions.push(nums)
    end
  end
end

def move9000(stacks, directions)
  for direction in directions
    quantity, from, to = direction
    to -= 1
    from -=1

    for i in 1..quantity do
      stacks[to].push(stacks[from].pop)
    end
  end
end

def move9001(stacks, directions)
  for direction in directions
    quantity, from, to = direction
    to -= 1
    from -=1
    
    stacks[to].push(*stacks[from].pop(quantity))
  end
end

populate(stacks, file, directions)
move9000(stacks, directions)

result = ""
for stack in stacks do
  result << stack[-1]
end

puts result




