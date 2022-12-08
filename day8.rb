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

    def visible_from_right(i, j, height)
        '''check if a particular tree is visible from the right'''
        for index in j+1...@forest[i].length
            return false if @forest[i][index] >= height
        end
        return true
    end

    def visible_from_left(i, j, height)
        '''check if a particular tree is visible from the left'''
        for index in 0...j
            return false if @forest[i][index] >= height
        end
        return true
    end

    def visible_from_bottom(i, j, height)
        '''check if a particular tree is visible from the bottom'''
        for index in i + 1...@forest.length
            return false if @forest[index][j] >= height
        end
        return true
    end

    def visible_from_above(i, j, height)
        '''check if a particular tree is visible from above'''
        for index in 0...i
            return false if @forest[index][j] >= height
        end
        return true
    end

    def count_visible_trees
        '''count how many trees are visible'''
        visible = 0
        for i in 0...@forest.length
            for j in 0...@forest[i].length
                height = @forest[i][j]

                # edges are always visible
                if i == 0 || i == @forest.length - 1 || j == 0 || j == @forest[0].length - 1
                    visible += 1
                    next
                end

                # check right
                if j < @forest[i].length
                    if visible_from_right(i, j, height)
                        visible += 1
                        next
                    end
                end

                # check left
                if i > 0
                    if visible_from_left(i, j, height)
                        visible += 1
                        next
                    end
                end

                # check bottom
                if i < @forest.length
                    if visible_from_bottom(i, j, height)
                        visible += 1
                        next
                    end
                end

                # check above
                if i > 0
                    if visible_from_above(i, j, height)
                        visible += 1
                        next
                    end
                end
            end
        end
        return visible
    end
end

solution = Day8.new('input/day8.txt')
puts solution.forest.inspect
puts solution.count_visible_trees