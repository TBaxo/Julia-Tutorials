using Dates
import Base.+
import Base.-
struct Clock
    hours::Integer
    minutes::Integer

    Clock(hours, minutes) = new((24 + (hours + floor(minutes / 60)) % 24) % 24, (60 + (minutes % 60)) % 60)
end

function show(io::IO, clock::Clock)
    function format_number_for_clock(number)
        return lpad(number, 2, "0")
    end

    formatted_string = "\"$(format_number_for_clock(clock.hours)):$(format_number_for_clock(clock.minutes))\""
    write(io, formatted_string)
end

"""
For Hours:
because we want to be able to handle negative time as well as positive time from a start point 00:00 which 
is equivalent to hour 24 in our case. And because we only care about numbers from 0 - 23 we can take any number
and use the Modulo (remainer) function on it to get the actual value we're interested in. 

We do this twice, on the value we are going to add or subtract to our starting point (24) and once again
on the whole sum.

For Minutes:
Similar to hours, we simply take a starting point for minutes, which is 60 (or 0, but since we're dealing with positive
and negative we use the next value up). 

"""
(+)(clock::Clock, minutes::Dates.Minute) = 
    Clock((24 + (clock.hours + floor((clock.minutes + minutes.value) / 60)) % 24 ) % 24, (60 + ((clock.minutes + minutes.value) % 60)) % 60)

(-)(clock::Clock, minutes::Dates.Minute) = 
    Clock((24 + (clock.hours + floor((clock.minutes - minutes.value) / 60)) % 24 ) % 24, (60 + ((clock.minutes - minutes.value) % 60)) % 60)
