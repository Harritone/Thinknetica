# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

VOWELS = %w(a e y u i  o)

alphabet = ('a'..'z').to_a

vowels = Hash.new
alphabet.each_with_index { |l, i| vowels[l] = i if VOWELS.include?(l)}

p vowels
