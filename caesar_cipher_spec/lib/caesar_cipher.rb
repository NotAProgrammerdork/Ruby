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
        if upp.index(i) + shift > 25
          upp[upp.index(i)-26 + shift]
        else
          upp[upp.index(i) + shift]
        end
      else
        if low.index(i) + shift > 25
          low[low.index(i)-26 + shift]
        else
          low[low.index(i) + shift]
        end
      end
    else
      i
    end
  end
  temp.join
end