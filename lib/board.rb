SYMBOL1 = "\u2600"
SYMBOL2 = "\u2601"

class Board
  attr_accessor :board

  def initialize
    @board = build
  end

  public

  def show
    clear_screen
    puts "-" * 40, "CONNECT FOUR".center(40), "-" * 40
    board.transpose.reverse.each do |arr|
      arr.each_with_index do |element, index|
        print "| #{element} "
        print "|\n" if index == arr.size - 1
      end
    end
    for num in 1..7 do
      print "  #{num} "
    end
    puts
  end

  def drop(index1, symbol)
    @board[index1].each_with_index do |element, index2|
      if element == 'o'
        board[index1][index2] = symbol
        break
      end
    end
  end

  def full?
    board.all? do |arr|
      arr.all? { |element| element != 'o' }
    end
  end

  def victory?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  private

  def build
    Array.new(7) { Array.new(6, 'o') }
  end

  def horizontal_win?
    board.transpose.each do |arr|
      slice_enum = arr.slice_when { |i, j| i != j }
      slice_enum.to_a.each do |sub_arr|
        return true if sub_arr.size == 4 && sub_arr[0] != 'o'
      end
    end
    false
  end

  def vertical_win?
    board.each do |arr|
      slice_enum = arr.slice_when { |i, j| i != j }
      slice_enum.to_a.each do |sub_arr|
        return true if sub_arr.size == 4 && sub_arr[0] != 'o'
      end
    end
    false
  end

  def diagonal_win?
    downright_downleft_diag.any? do |arr|
      arr.count(SYMBOL1) == 4 || arr.count(SYMBOL2) == 4
    end
  end

  def rightward_diag(board)
    diag_arr = []
    (0..board[0].size - 4).each do |num|
      right_arr = []
      board.each_with_index do |board, index|
        right_arr << board[index + num]
      end
      diag_arr << right_arr
    end
    diag_arr
  end

  def downright_downleft_diag
    diag_arr = []
    [board, board.reverse.transpose].each do |arr|
      (0..arr.size - 4).each do |num|
        diag_arr.push(*rightward_diag(arr[num..num + 3]))
      end
    end
    diag_arr
  end

  def clear_screen
    print `clear`
  end
end