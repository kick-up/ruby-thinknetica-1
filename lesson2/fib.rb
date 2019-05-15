# Заполнить массив числами фибоначчи до 100

fibo = [0, 1]
i = 0

loop do
  fibo_next = fibo[i] + fibo[i.next]
  break if fibo_next >= 100
  fibo << fibo_next
  i += 1
end

puts fibo
