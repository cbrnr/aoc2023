include("aoc.jl")

cookie = ""
input = get_aoc_input(4, cookie)

function get_points(card)
    winning = parse.(Int, split(strip(chopprefix(card[1], r"Card +\d+:"))))
    numbers = parse.(Int, split(strip(card[2])))
    matches = length(winning ∩ numbers)
    return matches > 0 ? 2^(matches - 1) : 0
end

cards = input |> strip |> x -> split(x, "\n") |> x -> split.(x, "|")

println("Part 1: ", sum(get_points.(cards)))
