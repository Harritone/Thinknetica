# Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. 
# Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения дискриминанта и корней на экран. 
# При этом возможны следующие варианты:
#   Если D > 0, то выводим дискриминант и 2 корня
#   Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
#   Если D < 0, то выводим дискриминант и сообщение "Корней нет"
# Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать  

def get_inputs
  puts 'Please, type in first number.'
  a = gets.chomp

  puts 'Please, type in second number.'
  b = gets.chomp

  puts 'Please, type in third number.'
  c = gets.chomp

  [a, b, c]
end

def check_input(a, b, c)
  (!a.nil? &&
    !b.nil? &&
    !c.nil?) &&
    (a.to_i.to_s == a &&
      b.to_i.to_s == b &&
      c.to_i.to_s == c)
end

def calc_roots(a, b, c)
  d = b**2 - 4 * a * c

  if d.positive?
    x1 = (-b + Math.sqrt(d)) / (2.0 * a)
    x2 = (-b - Math.sqrt(d)) / (2.0 * a)
    "D = #{d}, X1 = #{x1.round(2)}, X2 = #{x2.round(2)}"
  elsif d.zero?
    x = -b / (2.0 * a)
    "D = #{d}, X = #{x.round(2)}"
  else
    'There are no square roots'
  end
end

def init_app
  a, b, c = get_inputs until check_input(a, b, c)
  res = calc_roots(a.to_i, b.to_i, c.to_i)
  puts res
end

init_app
