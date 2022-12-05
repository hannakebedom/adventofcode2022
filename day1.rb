# DAY 1: Calorie Counting (December 5th, 2022)
require_relative 'fileops'

file = FileOps.read('input/day1.txt')

def most_calories(file)
  max = 0
  calories = 0

  for line in file do
    if line[0]
      num = line[0..-1].to_i
      calories += num
    else
      max = calories if calories > max
      calories = 0
    end
  end

  return max
end


def top3_calories(file)
  calorie_amounts = []
  calories = 0

  for line in file do
    if line[0]
      num = line[0..-1].to_i
      calories += num
    else
      calorie_amounts.push(calories)
      calories = 0
    end
  end

  return calorie_amounts.max(3).sum
end

puts top3_calories(file)
