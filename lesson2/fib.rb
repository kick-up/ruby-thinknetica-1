# Заполнить массив числами фибоначчи до 100

fibbonacci = [0, 1]
next_element = 1

while next_element < 100
  fibbonacci << next_element
  next_element = fibbonacci[-1] + fibbonacci[-2]
end
