def guessing_game
  answer = (1..100).to_a.sample
  guess = nil
  counter = 0
  until answer == guess
    puts "guess the number"
    guess = Integer(gets.chomp)
    counter +=1
    puts "too low!" if answer > guess
    puts "too high" if answer < guess
  end
  puts "you got it in #{counter} tries!"
end

def shuffle_lines
  puts "Enter filename"
  filename = gets.chomp
  lines = File.readlines(filename).map(&:chomp).shuffle
  File.open("#{filename.delete(".txt")}-shuffled.txt", "w") do |f|
    lines.each do |line|
      f.puts line
    end
  end
end


shuffle_lines
  
    