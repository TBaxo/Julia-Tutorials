"""
Imports
"""

import Base.+
import Base.-


"""
immutable structure for cartesian co-ordinate
"""
struct Point
    x::Integer
    y::Integer

    Point() = new(0, 0)
    Point(x, y) = new(x, y)
    Point((x, y)) = new(x, y)
end
(+)(point1::Point, point2::Point) = Point(point1.x + point2.x, point1.y + point2.y)
(-)(point1::Point, point2::Point) = Point(point1.x - point2.x, point1.y - point2.y)

"""
Enumerated type for heading and dictionary showing how to move when advancing for each heading
"""

@enum Heading NORTH = 0 EAST = 1 SOUTH = 2 WEST = 3
const heading_advance_dictionary = Dict{Heading,Point}(
    NORTH => Point(0, 1),
    EAST => Point(1, 0),
    SOUTH => Point(0, -1),
    WEST => Point(-1, 0)
)

"""
Robot structure:
point: representing it's position via cartesian co-ordinate
heading: direction it's facing using compass directions
"""
mutable struct Robot
    position::Point
    heading::Heading

    Robot(coordinates::Tuple{Integer,Integer}, heading::Heading) = new(Point(coordinates[1], coordinates[2]), heading)
    Robot(x::Integer, y::Integer, heading::Heading) = new(Point(x, y), heading)
end

position(robot::Robot) = robot.position
heading(robot::Robot) = robot.heading

turn_right!(robot::Robot) = robot.heading = Heading((Int(robot.heading) + 1) % 4)
turn_left!(robot::Robot) = robot.heading = Heading((4 + Int(robot.heading) - 1) % 4)
advance!(robot::Robot) = robot.position = robot.position + heading_advance_dictionary[robot.heading]
