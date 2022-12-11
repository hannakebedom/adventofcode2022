# --- Day 10: Cathode-Ray Tube ---
require_relative 'fileops'

class Day10
    attr_accessor :file, :signal_strengths

    KEY_CYCLES = [20, 60, 100, 140, 180, 220]

    def initialize(file_name)
        @file = FileOps.read(file_name)
        @signal_strengths = []
        read_commands
    end

    def sum_signal_strengths
        @signal_strengths.sum
    end

    def read_commands
        cycle = 1
        x = 1

        for line in @file
            op, value = line.split(' ')
            value = value.to_i

            if op.start_with?("addx")
                @signal_strengths << ((cycle + 1) * (x)) if KEY_CYCLES.include?(cycle + 1)
                cycle += 2
                x += value
            else
                cycle += 1
            end

            @signal_strengths << (cycle * x) if KEY_CYCLES.include?(cycle) 
        end
    end
end

solution = Day10.new('input/day10.txt')
puts solution.sum_signal_strengths