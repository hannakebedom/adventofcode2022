# --- Day 8: Treetop Tree House ---
require_relative 'fileops'

class Day8
    attr_accessor :file, :forest

    def initialize(file_name)
        @file = FileOps.read(file_name)
        @forest = []
        build_forest
    end

    def build_forest
        '''create a matrix from the input file'''
        for line in @file
            @forest << line.split('').map(&:to_i)
        end
    end

    def visible_looking_right(i, j, height)
        '''number of trees visible looking right'''
        count = 0
        for index in j+1...@forest[i].length
            count += 1
            return count if @forest[i][index] >= height
        end
        return count
    end

    def visible_looking_left(i, j, height)
        '''number of trees visible looking left'''
        count = 0
        for index in (j - 1).downto(0)
            count += 1
            return count if @forest[i][index] >= height
        end
        return count
    end

    def visible_looking_down(i, j, height)
        '''number of trees visible looking down'''
        count = 0
        for index in i + 1...@forest.length
            count += 1
            return count if @forest[index][j] >= height
        end
        return count
    end

    def visible_looking_up(i, j, height)
        '''number of trees visible when looking up'''
        count = 0
        for index in (i - 1).downto(0)
            count += 1 
            return count if @forest[index][j] >= height
        end
        return count
    end

    def optimal_scenic_score
        '''find tree with the highest optimal scenic score'''
        max = 0
        for i in 0...@forest.length
            for j in 0...@forest[i].length
                height = @forest[i][j]
                scenic_score = 1

                # scenic score will always be 0 for edges
                if i == 0 || i == @forest.length - 1 || j == 0 || j == @forest[0].length - 1 || height == 0
                    next
                end

                # check right
                scenic_score *= visible_looking_right(i, j, height)

                # check left
                scenic_score *= visible_looking_left(i, j, height)

                # check bottom
                scenic_score *= visible_looking_down(i, j, height)

                # check above
                scenic_score *= visible_looking_up(i, j, height)

                max = scenic_score if scenic_score > max
            end
        end
        return max
    end
end

solution = Day8.new('input/day8.txt')
puts solution.optimal_scenic_score