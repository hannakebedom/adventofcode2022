# --- Day 2: Rock Paper Scissors (Dec. 6th, 2022) ---
require_relative 'fileops'

class Day2
    attr_accessor :total_score

    ROCK = ['A', 'X']
    PAPER = ['B', 'Y']
    SCISSORS = ['C', 'Z']

    MOVES = {
        'A' => 1,
        'X' => 1,
        'B' => 2,
        'Y' => 2,
        'C' => 3,
        'Z' => 3
    }

    WIN = {
        'A' => 'Y',
        'B' => 'Z',
        'C' => 'X'
    }

    DRAW = {
        'A' => 'X',
        'B' => 'Y',
        'C' => 'Z'
    }

    LOSE = {
        'A' => 'Z',
        'B' => 'X',
        'C' => 'Y'
    }

    def initialize(file_name)
        @file = FileOps.read(file_name)
        @total_score = 0
    end

    def rock_paper_scissors
        for line in @file
            if line[2] == 'X'
                player1, player2 = line[0], LOSE[line[0]]
            elsif line[2] == 'Y'
                player1, player2 = line[0], DRAW[line[0]]
            elsif line[2] == 'Z'
                player1, player2 = line[0], WIN[line[0]]
            end

            outcome = determine_winner(player1, player2)
            puts "score: #{outcome + MOVES[player2]}"
            @total_score += outcome + MOVES[player2]
        end
    end

    def determine_winner(player1, player2)
        '''given the moves of two players returns the winner'''
        if MOVES[player1] == MOVES[player2]
            return 3
        elsif ROCK.include?(player1) && SCISSORS.include?(player2)
            return 0
        elsif SCISSORS.include?(player1) && PAPER.include?(player2)
            return 0
        elsif PAPER.include?(player1) && ROCK.include?(player2)
            return 0
        else
            return 6
        end
    end
end

solution = Day2.new('input/day2.txt')
solution.rock_paper_scissors
puts solution.total_score


