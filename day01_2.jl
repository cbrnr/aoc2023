include("aoc.jl")

cookie = ""
input = get_aoc_input(1, cookie)

function extract_digits(s)
    re = r"(\d|one|two|three|four|five|six|seven|eight|nine)"
    digits = join([m.captures[1] for m in eachmatch(re, s, overlap=true)])
    digits = replace(
        digits,
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9"
    )
    return parse(Int, digits[1] * digits[end])
end

println("Part 2: ", sum(extract_digits.(split(input))))
