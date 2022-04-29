dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(input_string, dictionary)
    all_possible_substrings = []
    array_of_split_words = []
    substrings = {}
    no_punctuation_string = input_string.gsub(/[^A-Za-z0-9\s]/i, '').downcase
    word_array = no_punctuation_string.split(" ")
    word_array.each do |word|
        i = 0
        until i == word.length do 
            j = -1
            until j == ((word.length*-1) - 1) do 
                all_possible_substrings << word[i..j]
                j -= 1
            end
            i += 1
        end
    end 
all_possible_substrings.delete("")
included_strings = all_possible_substrings.select {|string| dictionary.include?(string)} 
included_strings
result = included_strings.reduce(Hash.new(0)) do |output, string|
    output[string] += 1
    output
end
result
end
substrings("Howdy partner, sit down! How's it going?", dictionary)
