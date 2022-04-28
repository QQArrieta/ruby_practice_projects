def ceasar_cipher(input_string, shift_factor)
    
    actual_shift = shift_factor%26    
    individual_letters_string = input_string.split("")
    ascii_original = individual_letters_string.map do |element|
        if element=="!"||element==" "||element=="."|| element==","|| element=="?"
            element
        else 
            element.ord
        end
    end
    ascii_shifted = ascii_original.map do |element| 
        if element=="!"||element==" "||element=="."|| element==","|| element=="?"
            element
        elsif element.between?(65,90) && element+actual_shift>90
            element+actual_shift-26
        elsif element.between?(97,122) && element+actual_shift>122
            element+actual_shift-26
        else
            element+actual_shift
        end
    end
    new_string = ascii_shifted.map{|element| element.chr}
    puts %Q["#{new_string.join("")}"]
            
end
ceasar_cipher("What a string!", 5)