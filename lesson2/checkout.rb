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

@run = true

@total = 0

def checkout
  while @run
    puts "Введите название товара:"
    item = gets.chomp.to_s
    if item == "stop"
      @run = false
    else
      puts "Укажите количество товара:"
      quantity = gets.chomp.to_i
      puts "Укажите цену товара:"
      price = gets.chomp.to_f
      @basket[item] = [price, quantity]
    end
  end
end

def print_basket
  puts @basket
  @basket.each do |k, v|
    total_per_item = v[0] * v[1]
    puts "Total price for #{k} is #{total_per_item}"
    @total += total_per_item
  end
  puts "Your total price is #{@total}"
end

checkout
print_basket
