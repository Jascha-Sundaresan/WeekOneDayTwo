require 'active_support/core_ext/object/deep_dup.rb'

class Board
  attr_accessor :grid
  
  def initialize 
    @grid = [[" "," "," "],[" "," "," "],[" "," "," "]]
  end
  
  def display
    puts "  1 2 3"
    grid.each_with_index do |row, idx|
      idx += 1
      puts "#{idx} #{row.join("|")}"
    end
  end
  
  def won?
    rows? || columns? || diag?
  end
  
  def place_mark(pos, mark)
    x, y = pos
    grid[x][y] = mark
  end
  
  def valid_choices
    [0, 1, 2]
  end
     
  def valid_move?(pos)
    valid_choices.include?(pos.first) &&
    valid_choices.include?(pos.last) && 
    empty?(pos) 
  end
  
  def full?
    (0..2).each do |col|
      (0..2).each do |row|
        return false if empty?([row,col])
      end
    end
    
    true
  end
    
    
  private
  
  def empty?(pos)
    x,y = pos
    grid[x][y] == " "
  end
  
  def rows?
    grid.any? { |row| row.uniq.length == 1 && row.first != " " }
  end
  
  def columns?
    grid.transpose.any? { |col| col.uniq.length == 1 && col.first != " " }
  end
  
  def diag?
    left? || right?
  end
  
  def left?
    diag = [grid[0][0],grid[1][1],grid[2][2]]
    diag.uniq.length == 1 && diag.first != " "
  end
  
  def right?
    diag = [grid[2][0],grid[1][1],grid[0][2]]
    diag.uniq.length == 1 && diag.first != " "
  end

end


class Player
  attr_accessor :mark
  
  def move(pos, board)
    board.place_mark(pos, mark)
  end
  
end


class HumanPlayer < Player
  attr_accessor :name
  
  class InputError < StandardError;end
  
  def choose_move(board)
    begin
      pos = get_position 
      raise InputError.new("That's not a valid move") unless board.valid_move?(pos)
      self.move(pos, board)
    rescue InputError => error
      puts error
      retry
    rescue ArgumentError => error
      puts error
      retry
    end
  end
  
  private
  
  def get_position
    puts "pick row"
    col = Integer(gets.chomp)
    puts "pick column"
    row = Integer(gets.chomp)
    [row - 1 ,col - 1]
  end
    
  
end

class ComputerPlayer < Player
  attr_accessor :name
  
  def choose_move(board)
    can_win(board) ? self.move(can_win(board), board) : random_move(board)
  end
  
  def can_win(board)
    (0..2).each do |col|
      (0..2).each do |row|
        test_board = create_test_board(board)
        pos = [row, col]
        next unless test_board.valid_move?(pos)
        self.move(pos, test_board)
        return pos if test_board.won?
      end
    end
    nil
  end
  
  def create_test_board(board)
    test_board = Board.new
    test_board.grid = board.grid.deep_dup
    test_board
  end
  
  def random_move(board)
    possible_moves = []
    (0..2).each do |col|
      (0..2).each do |row|
        pos = [row, col]
        possible_moves << pos if board.valid_move?(pos)
      end
    end
    self.move(possible_moves.sample, board)
  end
    
end

class Game
  attr_reader :player1, :player2, :board 
  attr_accessor :current_player
  
  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @player1.mark, @player2.mark = "X", "O"
    @player1.name, @player2.name = "Player 1", "Player 2"
    @board = Board.new
    @current_player = player1
  end
  
  def play      
    until board.won? || board.full?
      board.display
      current_player.choose_move(board)
      switch_players
    end
    switch_players
    puts (board.won? ? "#{current_player.name} wins!" : "Draw")
    board.display
  end
  
  private
  
  def switch_players
    if current_player == player1
      self.current_player = player2
    else
      self.current_player = player1
    end
  end
    
end

p1 = HumanPlayer.new
p2 = ComputerPlayer.new
g = Game.new(p1,p2)
g.play
