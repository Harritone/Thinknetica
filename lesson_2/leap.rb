# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) Алгоритм опредления високосного года: www.adm.yar.ru

def leap?(year)
  return true if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

  false
end

def calculate_days(day, month, year)
  return day if month == 1

  days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_months[1] = 29 if leap?(year)
  days_in_months.take(month - 1).reduce(&:+) + day
end

def get_input
  puts 'Please, input day of the month'
  day = gets.chomp.to_i

  puts 'Please, input number of month'
  month = gets.chomp.to_i

  puts 'Please, input year'
  year = gets.chomp.to_i

  [day, month, year]
end

def init_app
  day, month, year = get_input
  result = calculate_days(day, month, year)
  puts "The serial number from the start of the year is #{result}."
end

init_app
