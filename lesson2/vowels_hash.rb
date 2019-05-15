# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).

alphabet = ("a".."z")

vowels = %w[a e i o u]

vowels_hash = Hash.new(0)

alphabet.each.with_index(1) do |letter, index|
  vowels_hash[letter] = index if vowels.include?(letter)
end

puts vowels_hash
