def bubble_sort(array)
    (array.length - 1).times do
        y = 0
        loop do
            if array[y] > array[y + 1]
                temp1 = array[y]
                array[y] = array[y + 1]
                array[y + 1] = temp1
            end
            y += 1
            break if array[y] == array[-1]
        end
    end
    array
end

p bubble_sort([4,3,78,2,0,2])