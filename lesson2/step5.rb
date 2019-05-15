# Заполнить массив числами от 10 до 100 с шагом 5

step = []

(10..100).each do |x|
  if x % 5 == 0
    step << x
  end
end

print step
