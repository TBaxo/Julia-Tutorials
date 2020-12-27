const circle_radius_point_dictionary = Dict{Integer,Integer}(
    1 => 10,
    5 => 5,
    10 => 1
)
const largest_circle_radius = maximum(keys(circle_radius_point_dictionary))

function score(x, y)
    if (!isinside(x, y, largest_circle_radius)) 
        return 0
    end
    return minimum(filter((pair) -> isinside(x, y, pair.first), circle_radius_point_dictionary)).second
end



"""we do not need to specify the centre point in this case since all circles have the same origin (0,0)"""

function isinside(x, y, radius)
    return x^2 + y^2 <= radius^2
end


println(score(-5.0, 0.0))