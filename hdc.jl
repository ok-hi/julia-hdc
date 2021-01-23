using Random
import Base: +, *

# HYPERPARAMS
rand_name_len = 12
vec_len = 10000

# basic constructor for an hdc vector. really it's just a wrapper so you
# don't have to call rand(0:1, vec_len) all the time
struct hdc_vector
    value::Array{Bool,1}
end

struct item_memory
    mem::Dict{String,hdc_vector}
end

function init_mem()
    return item_memory(Dict{String,hdc_vector}())
end

function push(mem::item_memory, name = randstring(rand_name_len))
    new_vec = init_vec()
    push!(mem.mem, name => new_vec)
    return new_vec
end

# init_vec is just a wrapper for initialization
function init_vec(value = rand(0:1, vec_len))
    return hdc_vector(value)
end

# bsc bundling operation (addition with a threshold of 1)
function +(a::hdc_vector, b::hdc_vector)
    x = a.value + b.value
    x[x .== 1] = rand(0:1, length(x[x .== 1])) # replace all ones in x with either a 1 or a 0 (random)
    x[x .== 2] = ones(Int64, length(x[x .== 2])) # replace all twos with a 1
    return init_vec(x)
end

# bsc binding operation
function *(a::hdc_vector, b::hdc_vector)
    new_val = a.value .⊻ b.value
    return init_vec(new_val)
end

# hamming distance
function hdist(a::hdc_vector, b::hdc_vector)
    return sum(a.value .!= b.value)
end
