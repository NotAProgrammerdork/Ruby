puts "######################"
puts "####   LOOPING   #####"
puts "######################"
puts

def single_fibs(n)
    ary = [0, 1]
    ary.length.upto(n) do |i|
        ary << ary[ary.length - 1] + ary[ary.length - 2]
    end
    ary[n]
end
puts single_fibs(9)

puts

def fibs(n)
    ary = [0, 1]
    while(ary.length <= n)
        ary << ary[ary.length-1] + ary[ary.length-2]
    end
    ary.join(" ")
end
puts fibs(9)

puts

puts "######################"
puts "###   RECURSION   ####"
puts "######################"
puts

def single_fibs_rec(n)
    n < 2 ? n : single_fibs_rec(n-1) + single_fibs_rec(n-2)
end
p single_fibs_rec(9)

puts

def fibs_rec(n, ary=[0, 1])
    n < ary.length ? ary.join(" ") : fibs_rec(n, ary << ary[ary.length-1] + ary[ary.length-2])
end
puts fibs_rec(9)