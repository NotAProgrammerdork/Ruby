def substrings(string, dictionary)
    dictionary.reduce(Hash.new(0)) do |acc, n|
        string.downcase.split.each do |i|
            i.include?(n) ? acc[n] += 1 : acc;
        end
        acc
    end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)