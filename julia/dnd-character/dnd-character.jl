using Random

const ability_modifier_dictionary = Dict{Integer,Integer}(
    3 => -4,
    4 => -3,
    5 => -3,
    6 => -2,
    7 => -2,
    8 => -1,
    9 => -1,
    10 => 0,
    11 => 0,
    12 => 1,
    13 => 1,
    14 => 2,
    15 => 2,
    16 => 3,
    17 => 3,
    18 => 4
)

function modifier(ability)
    if !ability in keys(ability_modifier_dictionary)
        error("Invalid ability value")
    end

    return ability_modifier_dictionary[ability]
end

function ability()
    return rand(3:18)
end

mutable struct DNDCharacter
    strength::Integer
    dexterity::Integer
    constitution::Integer
    intelligence::Integer
    wisdom::Integer
    charisma::Integer
    hitpoints::Integer

    function DNDCharacter() 
        abilities = zeroes(6)
        map!(x -> ability(), abilities)

        return new(
            x[1],
            x[2],
            x[3],
            x[4],
            x[5],
            x[6],
            (10 + modifier(x[3])) / 2
        )
    end
end
