# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).

alphabet = ("a".."z")

count = (1..26)

vowels = ["a", "e", "i", "o", "u"]

vowels_hash = Hash.new

alphabet.zip(count).each do |x, y|
  if vowels.include?(x)
    vowels_hash[x] = y
  end
end

puts vowels_hash
