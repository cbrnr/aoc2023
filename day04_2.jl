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

function process_deck(cards)
    deck = Dict(k => 1 for k in 1:length(cards))
    for (i, card) in enumerate(cards)
        n = matches(card)
        for c in i + 1:min(length(cards), i + n)
            deck[c] += deck[i]
        end
    end
    return deck
end

println("Part 2: ", sum(values(process_deck(cards))))
