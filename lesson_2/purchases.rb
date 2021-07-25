# 6. Сумма покупок. Пользователь вводит поочередно название товара, 
# цену за единицу и кол-во купленного товара (может быть нецелым числом). 
# Пользователь может ввести произвольное кол-во товаров до тех пор, 
# пока не введет "стоп" в качестве названия товара. 
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, 
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

def get_input
  result = {}

  puts 'Initializing the app'
  sleep(1)
  puts 'Note: to start calculate, input "stop" when promted to input the title of the product'
  sleep(1)

  loop do
    puts 'Input the title of the product.'
    product = gets.chomp
    break if product == 'stop'

    puts "Input the price of the #{product}"
    price = gets.chomp.to_f

    puts "Input the quantity of the #{product}"
    quantity = gets.chomp.to_i

    result[product] = { price: price, quantity: quantity }
  end

  result
end

def init_app
  result = get_input
  total = 0
  i = 1
  result.each do |prod, v|
    puts "#{i}. #{prod}: price - #{v[:price]}, quantity - #{v[:quantity]}, total price for product: $#{v[:price] * v[:quantity]}"
    total += v[:price] * v[:quantity]
    i += 1
  end
  puts "Total amount is $#{total}"
end

init_app
