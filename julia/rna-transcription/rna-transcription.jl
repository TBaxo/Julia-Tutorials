

const not_nucleotide_type_regex  = r"[^AGCT]+" 
const dna_to_rna_dictionary = Dict{Char,Char}(
    'A' => 'U', 
    'C' => 'G', 
    'G' => 'C', 
    'T' => 'A')
function to_rna(dna::String)

    if (dna == "")
        return dna
    end

    if occursin(not_nucleotide_type_regex, dna)
        throw(ErrorException("Invalid nucleotide detected in string"));
    end

    return String([dna_to_rna_dictionary[x] for x in dna])

end


