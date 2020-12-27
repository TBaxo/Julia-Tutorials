struct Clock
    hours::Integer
    minutes::Integer

    Clock(hours, minutes) = new((24 + (hours % 24) + floor(minutes / 60)) % 24, abs(minutes % 60))
end

function show(io::IO, clock::Clock)
    function format_number_for_clock(number)
        return lpad(number, 2, "0")
    end

    print("\"\\\"$(format_number_for_clock(clock.hours)):$(format_number_for_clock(clock.minutes))\"\\")
end




clock = Clock(8, -60)
clock2 = Clock(8, -30)