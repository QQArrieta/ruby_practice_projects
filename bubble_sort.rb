def bubble_sort(array)
    (array.length-1).times do
        i = 0
        until i==array.length-1 do
            if array[i]>array[i+1]
                array[i], array[i + 1] = array[i + 1], array[i]
                i += 1
            else
                i += 1
            end
        end
    end
    p array
end
bubble_sort([4,3,78,2,100,500,0,2,1])
