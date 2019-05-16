# Заданы три числа, которые обозначают число, месяц, год
# (запрашиваем у пользователя). Найти порядковый номер даты,
# начиная отсчет с начала года. Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в ruby методы для этого вроде
# Date#yday или Date#leap?)
# Алгоритм опредления високосного года: www.adm.yar.ru

# Високосный год вычисляется с помощью простого алгоритма.
# К сожалению, существуют системы и приложения, которые не определяют
# 2000 г. как високосный, и при использовании этих систем даты после 29
# февраля 2000 г. могут оказаться ошибочно сдвинуты на один день.
# Високосный год определяется по следующему правилу:

# Год високосный, если он делится на четыре без остатка,
# но если он делится на 100 без остатка, это не високосный год.
# Однако, если он делится без остатка на 400, это високосный год.
# Таким образом, 2000 г. является особым високосным годом,
# который бывает лишь раз в 400 лет.

month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Day"
day = gets.to_i

puts "Month"
month = gets.to_i

puts "Year"
year = gets.to_i

count = []

puts "Lets go!"

if year % 4 == 0 && year % 100 != 1 || year % 400 == 0
  month_days[1] = 29
  count << month_days.take(month - 1)
else
  count << month_days.take(month - 1)
end

puts count.flatten.reduce(day, :+)