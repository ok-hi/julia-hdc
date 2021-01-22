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
    new_vec = init_vec()
    count = 0
    for (x, y) in zip(a.value, b.value)
        count += 1
        if x & y
            new_vec.value[count] = 1
        elseif x ⊻ y
            new_vec.value[count] = rand(0:1)
        else
            new_vec.value[count] = 0
        end
    end
    return new_vec
end
