# Площадь треугольника. Площадь треугольника можно вычислить, 
# зная его основание (a) и высоту (h) по формуле: 1/2*a*h. 
# Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.

def get_inputs
  puts 'Please, type in base of the triangle.'
  base = gets.chomp.to_i

  puts 'Please, type in height of the triangle.'
  height = gets.chomp.to_i

  [base, height]
end

def check_input(base, height)
  base.positive? && height.positive?
end

def calculate_square(base, height)
  1 / 2.to_f * base * height
end

def init_app
  base, height = get_inputs

  base, height = get_inputs until check_input(base, height)

  result = calculate_square(base, height)

  puts "The square of the triangle is #{result}"
end

init_app
