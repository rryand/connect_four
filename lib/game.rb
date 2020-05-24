require_relative "board"

class Game
  attr_reader :board, :player

  def initialize
    @board = Board.new
    @player = SYMBOL1
  end

  public

  def start
    until board.victory? || board.full?
      play_turn
      if board.full?
        board.show
        print "No more slots left. "
        print "It's a draw!\n" unless board.victory?
      elsif board.victory?
        board.show
        print "#{player} wins!\n"
      end
      switch_player
    end
  end

  private

  def input
    print "Pick a column to drop a #{player} :"
    choice = gets.chomp until valid?(choice)
    choice.to_i - 1
  end

  def play_turn
    board.show
    choice = input
    board.drop(choice, player)
  end

  def valid?(choice)
    (1..7).include? choice.to_i
  end

  def switch_player
    @player = @player == SYMBOL1 ? SYMBOL2 : SYMBOL1
  end
end

Game.new.start