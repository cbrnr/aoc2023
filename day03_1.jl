include("aoc.jl")

cookie = ""
input = get_aoc_input(3, cookie)

grid = permutedims(hcat(collect.(split(strip(input)))...))

"""Get indexes of digits in `grid` adjacent to `index`."""
function get_adjacent_digits(grid::Matrix{Char}, index::CartesianIndex{2})
    result = Set{CartesianIndex{2}}()
    for (row, col) in ((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1))
        neighbor = CartesianIndex(index[1] + row, index[2] + col)
        if checkbounds(Bool, grid, neighbor) && isdigit(grid[neighbor])
            push!(result, get_first_digit(grid, neighbor))
        end
    end
    return result
end

"""Get `grid` index of first digit of the number containing `index`."""
function get_first_digit(grid::Matrix{Char}, index::CartesianIndex{2})
    row, col = Tuple(index)
    while col > 1 && isdigit(grid[row, col - 1])
        col -= 1
    end
    return CartesianIndex(row, col)
end

"""Return part number given the `index` of its first digit."""
function part_number(grid::Matrix{Char}, index::CartesianIndex{2})
    row, col = Tuple(index)
    while col < size(grid, 2) && isdigit(grid[row, col + 1])
        col += 1
    end
    return parse(Int, join(grid[row, index[2]:col]))
end

symbols = findall(x -> !isdigit(x) && x != '.', grid)
numbers = []  # indices of part numbers
for symbol in symbols
    append!(numbers, get_adjacent_digits(grid, symbol))
end

println("Part 1: ", sum(part_number.(Ref(grid), numbers)))
