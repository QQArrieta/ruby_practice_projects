def stock_picker(array)
   buy_sell = []
   difference = 0
   for i in 0..array.length-2
        j = i+1
        for j in j..array.length-1
            if array[i]-array[j] < difference 
                buy_sell.clear()
                difference = array[i]-array[j]
                buy_sell << i
                buy_sell << j
            end 
        end
    end
    p buy_sell
end
stock_picker([100,17,3,6,9,15,8,6,1,10,30, 0])
