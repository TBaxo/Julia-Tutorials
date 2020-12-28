using Random
using Base.Iterators


const letters = collect('A':'Z')
const numbers = collect('0':'9')
const name_registry = Set{String}()
mutable struct Robot
    name::String

    Robot() = new("")
    
end

function set_name(instance::Robot)
    instance.name = create_random_unique_name()
    push!(name_registry, instance.name)
    return instance.name
end

function reset!(instance::Robot)
    instance.name = ""
end

function name(instance::Robot)
    instance.name == "" && return set_name(instance)

    return instance.name
end

function create_random_unique_name()
    while true
        new_name = string(randstring(letters, 2), randstring(numbers, 3))

        new_name in name_registry || return new_name;
    end
end



"""

function run_test()
    isname(x) = occursin(r"^[A-Z]{2}[0-9]{3}$", x)
    history = Set{String}()


    r1 = Robot();
    Random.seed!()
    for i in 1:100
        reset!(r1)
        isname(name(r1))
        !in(name(r1), history) || error("F4")
        push!(history, name(r1))
    end

    r2 = Robot()
    r3 = Robot()


    isname(name(r2))
    isname(name(r3))

    
    name(r2) != name(r3) || error("F")

    !in(name(r2), history) || error("F2")
    !in(name(r3), history) || error("F3")


    push!(history, name(r2))
    push!(history, name(r3))
end

"""