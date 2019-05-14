# Заполнить массив числами фибоначчи до 100

def fib(n)
  fibo = [0, 1]
  i = 0
  while i < n
    puts fibo[i]
    fibo_next = fibo[i] + fibo[i.next]
    fibo.push fibo_next
    i += 1
  end
end

fib(100)
