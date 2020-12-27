const nucleotide_types = ["A", "C", "G", "T"];
const not_nucleotide_type_regex  = r"[^AGCT]+" 
function count_nucleotides(strand::String)

    if occursin(not_nucleotide_type_regex, strand)
        throw(DomainError("Invalid nucleotide detected in string"));
    end


    function count_occurences(nucleotide::String)
        nucleotide_regex::Regex = Regex(nucleotide)
        return count(nucleotide_regex, strand)
    end

    return Dict{Char,Integer}(first(nucleotide) => count_occurences(nucleotide) for nucleotide in nucleotide_types)
end
