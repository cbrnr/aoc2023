include("aoc.jl")

cookie = ""
input = get_aoc_input(2, cookie)

values = split(strip(input), "\n")

function get_cubes(s::AbstractString, color::AbstractString)
    m = match(Regex("(\\d+) $(color)"), s)
    !isnothing(m) && return parse(Int, m.captures[1])
    return 0
end

function get_minimum_set(game::AbstractVector{<:AbstractString})
    r_min, g_min, b_min = 0, 0, 0
    for s in game
        red, green, blue = get_cubes.(s, ["red", "green", "blue"])
        r_min = max(r_min, red)
        g_min = max(g_min, green)
        b_min = max(b_min, blue)
    end
    r_min * g_min * b_min
end

games = split.(chopprefix.(values, r"Game \d+: "), "; ")

println("Part 2: ", sum(*(get_minimum_set(game)...) for game in games))
