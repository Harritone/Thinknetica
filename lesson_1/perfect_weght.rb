# This is a base implementation of calculating the perfect weight

def get_inputs
  puts 'Hello! What is your name?'
  name = gets.chomp

  puts 'How tall in cm are you?'
  height = gets.chomp

  until check_height(height)
    puts 'Please enter a valid height in cm, it should be greater then 100 and less then 250 (e.g 176)'
    puts 'How tall are you?'
    height = gets.chomp
  end
  [name, height.to_i]
end

def check_height(height)
  height.to_i > 100 && height.to_i < 250
end

def calculate_body_mass_index(height)
  (height - 110) * 1.15
end

def check_ideality(bmi)
  return 'Your weight is already perfect.' unless bmi.positive?

  'You need to loose weght, sorry.'
end

def output_results(name, height)
  bmi = calculate_body_mass_index(height)
  string = check_ideality(bmi)
  puts "#{name.capitalize}! #{string}"
end

name, height = get_inputs

output_results(name, height)
