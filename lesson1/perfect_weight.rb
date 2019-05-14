# Идеальный вес. Программа запрашивает у пользователя имя и рост и
# выводит идеальный вес по формуле <рост> - 110, после
# чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка
# "Ваш вес уже оптимальный".

WEIGHT_COEFICIENT = 110 #coeficient

puts "Your name: "
name = gets.chomp.capitalize

puts "Your height in centimeters (integers only): "
height = gets.to_i

perfect_weight = height - WEIGHT_COEFICIENT

if perfect_weight < 0
  puts "#{name}, your weight is already optimal"
else
  puts "#{name}, your perfect weight is #{perfect_weight} kg."
end
