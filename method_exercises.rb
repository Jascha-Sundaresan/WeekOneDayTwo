def valid_moves
  %w(rock paper scissors)
end

def real_move?(move)
  valid_moves.include?(move.downcase)
end

def draw?(player_move, computer_move)
  player_move == computer_move
end

def outcome(player, computer)
  { 
    ["rock", "paper"] => "Lose",
    ["paper", "rock"] => "Win",
    ["scissors", "paper"] => "Win",
    ["rock", "scissors"] => "Win",
    ["paper", "scissors"] => "Lose",
    ["scissors", "rock"] => "Lose"
    }[[player, computer]]
end

def rps(move)
  raise "not a real move" unless real_move?(move)
  computer_move = valid_moves.sample
  if draw?(move.downcase, computer_move)
    puts "#{move}, #{computer_move.capitalize}, Draw"
  else
    puts "#{move}, #{computer_move.capitalize}, #{outcome(move.downcase, computer_move)}"
  end
end

def remix(drinks)
  alcohols = []
  mixers = []
  
  drinks.each do |drink|
    alcohols << drink.first
    mixers << drink.last
  end
  
  new_alcohols = alcohols.shuffle
  
  new_alcohols.shuffle! until uniq_alcohols?(new_alcohols, alcohols)

  p new_alcohols
  new_alcohols.map.with_index do |alcohol, index| 
    [alcohol, mixers[index]]
  end
  
end

def uniq_alcohols?(new_alcohols, alcohols)
  (0...new_alcohols.length).each do |index|
    return false if new_alcohols[index] == alcohols[index]
  end
  true
end

