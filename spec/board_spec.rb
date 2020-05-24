require "board"

describe Board do
  let(:board) { Board.new }

  it "is a class instance" do
    expect(board).to be_an_instance_of Board
  end

  it "has instance variable, @board" do
    expect(board).to respond_to(:board)
  end

  describe "#build" do
    it "builds and return a board composed of arrays" do
      arr = board.board
      expect(arr.size).to eql(7)
      expect(arr.first.size).to eql(6)
    end 
  end

  describe "#show" do
    it "displays the board" do
      expect(subject).to receive(:print).at_least(2).times
      subject.show
    end
  end

  describe "#drop" do
    it "pushes a symbol" do
      expected = Array.new(6) { "o" }
      expected[0] = SYMBOL1
      board.drop(1, SYMBOL1)
      arr = board.instance_variable_get(:@board)
      expect(arr[1]).to eq(expected)
    end

    it "pushes a symbol to an array with an existing symbol" do
      expected = [SYMBOL1, SYMBOL2, SYMBOL1, 'o', 'o', 'o']
      arr1 = board.instance_variable_get(:@board)
      arr1[3] = [SYMBOL1, SYMBOL2, 'o', 'o', 'o', 'o']
      board.instance_variable_set(:@board, arr1)
      board.drop(3, SYMBOL1)
      arr2 = board.instance_variable_get(:@board)
      expect(arr2[3]).to eq(expected)
    end
  end

  describe "#full?" do
    it "detects if there is a full board" do
      full_arr = Array.new(7) { Array.new(6) { 'x' } }
      board.instance_variable_set(:@board, full_arr)
      expect(board.full?).to eq(true)
    end

    it "detects if the board is not full" do
      arr = board.instance_variable_get(:@board)
      arr[2] = %w[x x o o o o]
      arr[5] = %w[x x x x o o]
      expect(board.full?).to eq(false)
    end
  end

  describe "#victory?" do
    it "detects a horizontal win" do
      board.board[0][0] = SYMBOL1
      board.board[1][0] = SYMBOL1
      board.board[2][0] = SYMBOL1
      board.board[3][0] = SYMBOL1
      expect(board.victory?).to eq(true)
    end

    it "detects a vertical win" do
      board.board[0][0] = SYMBOL2
      board.board[0][1] = SYMBOL2
      board.board[0][2] = SYMBOL2
      board.board[0][3] = SYMBOL2
      expect(board.victory?).to eq(true)
    end

    it "detects a down-right diagonal win" do
      board.board[1][1] = SYMBOL1
      board.board[2][2] = SYMBOL1
      board.board[3][3] = SYMBOL1
      board.board[4][4] = SYMBOL1
      expect(board.victory?).to eq(true)
    end

    it "detects a down-left diagonal win" do
      board.board[0][5] = SYMBOL1
      board.board[1][4] = SYMBOL1
      board.board[2][3] = SYMBOL1
      board.board[3][2] = SYMBOL1
      expect(board.victory?).to eq(true)
    end
  end
end