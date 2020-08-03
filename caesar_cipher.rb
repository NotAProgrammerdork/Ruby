def caesar_cipher(string, shift)
    low = ("a".."z").to_a
    upp = ("A".."Z").to_a
    temp = string.split("")
    until shift >= -26 && shift <= 25
        shift < -26 ? shift += 26 : shift -= 26
    end
    temp.map! do |i|
        if low.include?(i) || upp.include?(i)
            if i == i.upcase
                x = upp.index(i) + shift > 25 ? upp.index(i) - 26 + shift : upp.index(i) + shift
                upp[x]
            else
                x = low.index(i) + shift > 25 ? low.index(i) - 26 + shift : low.index(i) + shift
                low[x]
            end
        else
            i
        end
    end
    temp.join
end

caesar_cipher("What a string!", 5)