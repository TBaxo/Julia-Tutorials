"Your optional docstring here"
function distance(a, b)
    
    if length(a) != length(b) 
        throw(ArgumentError("Strand lengths are different"))
    end

    return length([i for i in 1:length(a) if a[i] != b[i]])
end

    
println(distance("abba", "aaba"))