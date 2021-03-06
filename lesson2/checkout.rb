# Сумма покупок.
# Пользователь вводит поочередно название товара,
# цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока
# не введет "стоп" в качестве названия товара. На основе введенных данных
# требуется:
# Заполнить и вывести на экран хеш, ключами которого являются названия
# товаров, а значением - вложенный хеш, содержащий цену за единицу товара
# и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

@basket = Hash.new

@total = 0

def shopping_cart
  loop do
    puts "Введите название товара. Для завершения покупок, введите stop."
    item = gets.chomp
    break if item.downcase == "stop"
    puts "Укажите количество товара:"
    quantity = gets.to_i
    puts "Укажите цену товара:"
    price = gets.to_f
    @basket[item] = {price: price, quantity: quantity}
  end
end

def print_basket
  puts @basket
  @basket.each do |name, info|
    total_per_item = info[:price] * info[:quantity]
    puts "Итоговая сумма за #{info[:quantity]} единиц(ы) товара #{name}: #{total_per_item} зимбабвийских долларов"
    @total += total_per_item
  end
  puts "К оплате итого: #{@total} зимбабвийских долларов"
end

shopping_cart
print_basket
