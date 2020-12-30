mutable struct CircularBuffer{T}
    buffer::Array{Union{Nothing,T}}
    head::Integer
    tail::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(Array{Union{Nothing,T}}(nothing, capacity), 1, 1)
    end
end

Base.count(cb::CircularBuffer) = count(x -> !isnothing(x), cb.buffer)

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    isfull = count(cb) >= length(cb.buffer)
    if !overwrite && isfull
        throw(BoundsError(cb.buffer, cb.tail))
    end

    cb.buffer[cb.tail] = item
    cb.tail = (cb.tail % length(cb.buffer)) + 1

    if isfull
        cb.head = cb.tail
    end

    return cb
end

function Base.popfirst!(cb::CircularBuffer)
    if cb.buffer[cb.head] === nothing
        throw(BoundsError(cb.buffer, cb.head))
    end

    oldValue = cb.buffer[cb.head]
    cb.buffer[cb.head] = nothing

    cb.head = (cb.head % length(cb.buffer)) + 1

    return oldValue
end

function Base.empty!(cb::CircularBuffer) 
    map!(x -> nothing, cb.buffer, cb.buffer)
    cb.tail = cb.head
    return cb
end

cb = CircularBuffer{Int}(3)
push!(cb, 1) === cb
push!(cb, 2) === cb
push!(cb, 3) === cb
popfirst!(cb) == 1
push!(cb, 4) === cb
push!(cb, 5; overwrite=true) === cb

