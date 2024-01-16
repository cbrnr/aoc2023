include("aoc.jl")

cookie = ""
input = get_aoc_input(5, cookie)

function process_almanac(almanac)
    all_maps = []
    maps = []
    current = 0
    for line in almanac[2:end]
        line == "" && continue
        if endswith(line, "map:")
            current += 1
            !isempty(maps) && push!(all_maps, maps)
            maps = []
            continue
        end
        dest, src, len = parse.(Int, split(line))
        push!(maps, (dest, src, len))
    end
    push!(all_maps, maps)  # last map
    return all_maps
end

function get_mapping(number, map_)
    for (dest, src, len) in map_
        if number in src:src + len - 1
            return dest + number - src
        end
    end
    return number
end

function process_seed(seed, maps)
    for m in maps
        seed = get_mapping(seed, m)
    end
    return seed
end

function process_seeds(s, maps)
    # convert seed ranges to list of (start, stop)
    seeds = []
    for i in 1:2:length(s)
        push!(seeds, (s[i], s[i] + s[i + 1] - 1))
    end
    for (start, stop) in seeds
        println("$(start)–$(stop)")
    end
end

almanac = input |> strip |> x -> split(x, "\n")
seeds = almanac[1] |> x -> chopprefix(x, "seeds: ") |> split |> x -> parse.(Int, x)

maps = process_almanac(almanac)
# lowest = process_seeds(seeds, maps)

# println("Part 2: ", lowest)
