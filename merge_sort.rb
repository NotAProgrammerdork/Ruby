def merge_sort(arr)
    if arr.length <= 2
        sorting_half(arr)
    else
        left = merge_sort(arr.slice(0...arr.length/2))
        right = merge_sort(arr.slice(arr.length/2...arr.length))
        merging([left, right])
    end
end

def sorting_half(arr) 
    unless arr[1].nil? || arr[0] < arr[1]
        temp1 = arr[0]; temp2 = arr[1]
        arr[0] = temp2; arr[1] = temp1
    end
    arr
end

def merging(arr, final=[])
    unless arr[0].empty? || arr[1].empty?
        arr[0].each_with_index do |left, idx|
            a = left < arr[1][idx] ? left   : arr[1][idx]
            b = left < arr[1][idx] ? arr[0] : arr[1]
            b.delete(a)
            final << a
            return merging([arr[0], arr[1]], final)
        end
    else
        (arr[0].empty? ? arr[1] : arr[0]).each { |i| final << i }
    end
    final
end

p merge_sort([1,3,5,2,9,3])