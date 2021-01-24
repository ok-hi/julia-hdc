using Random
import Base: +, *

# HYPERPARAMS
rand_name_len = 12
vec_len = 10000

# basic constructor for an hdc vector. really it's just a wrapper so you
# don't have to call rand(0:1, vec_len) all the time
struct hdc_vector
    value::Array{Bool,1}
    hdc_vector(value = rand(0:1, vec_len)) = new(value)
end

# wrapper for creating an item memory
struct item_memory
    mem::Dict{String,hdc_vector}
    item_memory() = new(Dict{String,hdc_vector}())
end

# find the vector in an item memory with shortest hamming dist from a given vector
function find(i::item_memory, v::hdc_vector)
    d = vec_len
    match = nothing

    for (name, vec) in i.mem
        if hdist(v, vec) < d
            match = name
            d = hdist(v, vec)
        end
    end
    return match, d
end

# add a vector to an item memory, optionally giving it a name
function push(mem::item_memory, name = randstring(rand_name_len))
    new_vec = hdc_vector()
    push!(mem.mem, name => new_vec)
    return new_vec
end

# bsc bundling operation (addition with a threshold of 1)
function +(a::hdc_vector, b::hdc_vector)
    x = a.value + b.value
    x[x .== 1] = rand(0:1, length(x[x .== 1])) # replace all ones in x with either a 1 or a 0 (random)
    x[x .== 2] = ones(Int64, length(x[x .== 2])) # replace all twos with a 1
    return hdc_vector(x)
end

# bsc binding operation
function *(a::hdc_vector, b::hdc_vector)
    new_val = a.value .⊻ b.value
    return hdc_vector(new_val)
end

# hamming distance
function hdist(a::hdc_vector, b::hdc_vector)
    return sum(a.value .!= b.value)
end
