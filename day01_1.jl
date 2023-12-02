include("aoc.jl")

cookie = ""
input = get_aoc_input(1, cookie)

function extract_digits(s)
    digits = join([m.captures[1] for m in eachmatch(r"(\d)", s)])
    return parse(Int, digits[1] * digits[end])
end

println("Part 1: ", sum(extract_digits.(split(input))))
