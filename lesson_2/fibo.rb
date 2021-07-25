# 3. Заполнить массив числами фибоначчи до 100

MAX = 100

arr = [1, 2]

loop do
  next_num = arr.last(2).sum
  break if next_num >= MAX

  arr << next_num
end

p arr
