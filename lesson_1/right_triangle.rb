# Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет, 
# является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), 
# равнобедренным (т.е. у него равны любые 2 стороны)  
# или равносторонним (все 3 стороны равны) и выводит результат на экран. 
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) 
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. 
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

def get_inputs
  puts 'Please, type in first side of the triangle.'
  first_side = gets.chomp.to_i

  puts 'Please, type in second side of the triangle.'
  second_side = gets.chomp.to_i

  puts 'Please, type in third side of the triangle.'
  third_side = gets.chomp.to_i

  [first_side, second_side, third_side]
end

def check_input(first_side, second_side, third_side)
  (!first_side.nil? &&
    !second_side.nil? &&
    !third_side.nil?) &&
    (first_side.positive? &&
      second_side.positive? &&
      third_side.positive?)
end

def check_triangle(*args)
  right = 'right'
  isosc = 'isosceles'
  equal = 'equilateral and isosceles'
  triangle = 'just a regular one'

  return equal if args.uniq.size == 1
  return isosc if args.uniq.size == 2

  index_of_max = args.index(args.max)
  hypo = args.slice!(index_of_max)
  a, b = args

  (a**2 + b) == hypo**2 ? right : triangle
end

def init_app
  first_side, second_side, third_side = get_inputs until check_input(first_side, second_side, third_side)
  res = check_triangle(first_side, second_side, third_side)
  puts "This is a #{res} triangle!"
end

init_app
