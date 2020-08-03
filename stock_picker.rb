def stock_picker(array)
    hsh = Hash.new(0)
    array.each do |first|
        hsh[first] = Hash.new{0}
        array.slice((array.index(first) + 1)..-1).each {|second| hsh[first][second] = -first + second}
    end
    get_max_value(array, hsh)
end

def get_max_value(array, hash)
    all_values = hash.keys.reduce([]) {|acc, i| acc += hash[i].values}
    max_value = all_values.reduce(0) {|acc, i| acc < i ? acc = i : acc}
    buy_and_sell(array, hash, max_value)
end

def buy_and_sell(array, hash, max_value)
    buy = 0; sell = 0;
    hash.keys.each do |i|
        hash[i].keys.each do |y|
            if hash[i][y] == max_value
                sell = (hash[i].select {|k, v| v == hash[i][y]}).keys
                buy = (hash.select {|k, v| k == i}).keys
            end
        end
    end
    [array.index(buy.join.to_i)] + [array.index(sell.join.to_i)]
end

p stock_picker([17,3,6,9,15,8,6,1,10])