mutable struct CircularBuffer{T} <: AbstractVector{T}
    buffer::Array{Union{Nothing,T}}
    head::Integer
    tail::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(Array{Union{Nothing,T}}(nothing, capacity), 1, 1)
    end
end

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    bufferisfull = isfull(cb) 
    if !overwrite && bufferisfull
        throw(BoundsError(cb.buffer, cb.tail))
    end

    cb.buffer[cb.tail] = item
    cb.tail = nextposition(cb, "tail")

    if bufferisfull
        cb.head = cb.tail
    end

    return cb
end

function Base.pushfirst!(cb::CircularBuffer, item; overwrite::Bool=false)
    nextheadposition = prevposition(cb, "head")
    bufferisfull = isfull(cb) 
    if !overwrite && bufferisfull
        throw(BoundsError(cb.buffer, prevposition(cb, "head")))
    end

    cb.buffer[nextheadposition] = item
    cb.head = nextheadposition

    if bufferisfull
        cb.tail = cb.head
    end

    return cb
end

function Base.pop!(cb::CircularBuffer)
    nexttailposition = prevposition(cb, "tail")
    if cb.buffer[nexttailposition] === nothing
        throw(BoundsError(cb.buffer, tail))
    end

    oldValue = cb.buffer[nexttailposition]
    cb.buffer[nexttailposition] = nothing

    cb.tail = nexttailposition

    return oldValue
end

function Base.popfirst!(cb::CircularBuffer)
    if cb.buffer[cb.head] === nothing
        throw(BoundsError(cb.buffer, cb.head))
    end

    oldValue = cb.buffer[cb.head]
    cb.buffer[cb.head] = nothing

    cb.head = nextposition(cb, "head")

    return oldValue
end

function Base.empty!(cb::CircularBuffer) 
    map!(x -> nothing, cb.buffer, cb.buffer)
    cb.tail = cb.head
    return cb
end

function Base.first(cb::CircularBuffer)
    if cb.buffer[cb.head] === nothing
        throw(BoundsError(cb.buffer, cb.head))
    end

    cb.buffer[cb.head]
end

function Base.last(cb::CircularBuffer)
    if cb.buffer[prevposition(cb, "tail")] === nothing
        throw(BoundsError(cb.buffer, prevposition(cb, "tail")))
    end

    return cb.buffer[prevposition(cb, "tail")]
end

function Base.append!(cb::CircularBuffer, items; overwrite::Bool=false)
    @inbounds for i in items
        push!(cb, i, overwrite=overwrite)
    end 

    return cb
end


Base.getindex(cb::CircularBuffer, i::Integer) = cb.buffer[_convertindextolocalindex(cb, i)]
Base.setindex!(cb::CircularBuffer, item, i::Integer) = cb.buffer[_convertindextolocalindex(cb, i)] = item

Base.resize!(cb::CircularBuffer, nl::Integer) = resize!(cb.buffer, nl)

Base.length(cb::CircularBuffer) = count(x -> !isnothing(x), cb.buffer)

Base.size(cb::CircularBuffer) = size(cb.buffer)


function _convertindextolocalindex(cb::CircularBuffer, i::Integer)
    if (i > capacity(cb))
        throw(BoundsError(cb.buffer, i))
    end

    indexoffset = cb.head + (i - 1)
    if indexoffset <= capacity(cb)
        return indexoffset
    end

    return indexoffset % capacity(cb)
end

capacity(cb::CircularBuffer) = length(cb.buffer)

isfull(cb::CircularBuffer) = length(cb) >= capacity(cb)

nextposition(cb::CircularBuffer, pointername::String) = (getproperty(cb, Symbol(pointername)) % capacity(cb)) + 1

function prevposition(cb::CircularBuffer, pointername::String)
    pointervalue = getproperty(cb, Symbol(pointername))
    if pointervalue === 1
        return capacity(cb)
    end

    return pointervalue - 1
end



cb = CircularBuffer{Int}(5)
push!(cb, 1, overwrite=false)

cb == [1]