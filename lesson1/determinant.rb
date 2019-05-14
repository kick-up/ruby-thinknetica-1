# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с.
# Программа вычисляет дискриминант (D) и корни уравнения
# (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран.
# При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru).
# Для вычисления квадратного корня, нужно использовать
# Math.sqrt
#  Например,
# Math.sqrt(16)
#   вернет 4, т.е. квадратный корень из 16.
# D = b**2 - 4*a*c

puts "Укажите три коэффицента: "

puts "A"
a = gets.chomp.to_f

puts "B"
b = gets.chomp.to_f

puts "C"
c = gets.chomp.to_f

determinant = b**2 - 4*a*c
puts "Дискриминант равен #{determinant}"

if determinant > 0
  x1 = (Math.sqrt(determinant) - b)/2*a
  puts "Корень Х1 равен #{x1.round(2)}"
  x2 = (-Math.sqrt(determinant) - b)/2*a
  puts "Корень Х2 равен #{x2.round(2)}"
elsif determinant == 0
  x1 = -b/2*a
  puts "Корень Х1 = Х2 = #{x1.round(2)}"
else
  puts "Корней нет!"
end