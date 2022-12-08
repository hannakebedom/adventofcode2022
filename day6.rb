# --- Day 6: Tuning Trouble (Dec. 6th, 2022) ---
require_relative 'fileops'

class Day6
    def initialize(file_name)
        @file = FileOps.read(file_name)
        @first_marker = 0
    end

    def find_first_marker
        fourth = line[0]
        for line in @file
            for char in line

            end
        end
    end
end

solution = Day6.new('input/day6.txt')
solution.find_first_marker