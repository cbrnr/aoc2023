include("aoc.jl")

cookie = ""
input = get_aoc_input(4, cookie)

function matches(card)
    winning = parse.(Int, split(strip(chopprefix(card[1], r"Card +\d+:"))))
    numbers = parse.(Int, split(strip(card[2])))
    return length(winning ∩ numbers)
end

points(matches) = matches > 0 ? 2^(matches - 1) : 0

cards = input |> strip |> x -> split(x, "\n") |> x -> split.(x, "|")

println("Part 1: ", cards .|> matches .|> points |> sum)
