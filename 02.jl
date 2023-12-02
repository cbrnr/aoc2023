include("aoc.jl")

cookie = ""
input = get_aoc_input(2, cookie)

values = split(strip(input), "\n")

function get_cubes(s::AbstractString, color::AbstractString)
    m = match(Regex("(\\d+) $(color)"), s)
    !isnothing(m) && return parse(Int, m.captures[1])
    return 0
end

function check_possible(s::AbstractString)
    red, green, blue = get_cubes.(s, ["red", "green", "blue"])
    if (red > 12 || green > 13 || blue > 14)  # impossible
        return false
    end
    return true
end

ids = parse.(Int, [m.captures[1] for m in match.(r"Game (\d+): ", values)])
games = split.(chopprefix.(values, r"Game \d+: "), "; ")

counter = 0
for (id, game) in zip(ids, games)
    if all(check_possible.(game))
        counter += id
    end
end
