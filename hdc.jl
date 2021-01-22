using Random
import Base: +, *

# HYPERPARAMS
rand_name_len = 12
vec_len = 10

# basic constructor for an hdc vector. really it's just a wrapper so you
# don't have to call rand(0:1, vec_len) all the time
struct hdc_vector
    value::Array{Bool,1}
end

# init_vec is just a wrapper for initialization
function init_vec(value = rand(0:1, vec_len))
    return hdc_vector(value)
end

# bsc bundling operation
function +(a::hdc_vector, b::hdc_vector)
    x = a.value + b.value
    x[x .== 1] = rand(0:1, length(x[x .== 1]))
    x[x .== 2] = ones(Int64, length(x[x .== 2]))
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
