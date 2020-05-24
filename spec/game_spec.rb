require "game"

describe Game do
  let(:game) { Game.new }

  it "is a class instance" do
    expect(game).to be_an_instance_of Game
  end

  describe "#start" do
    let(:board) { game.instance_variable_get(:@board) }
    before do
      expect(game).to respond_to(:start)
      allow(game).to receive(:play_turn).and_return(nil)
      allow(game).to receive(:switch_player).and_return(nil)
      allow(board).to receive(:show).and_return(nil)
    end
    it "ends if board is full" do
      allow(board).to receive(:victory?).and_return(false)
      allow(board).to receive(:full?).and_return(true)
      expect(board).to receive(:full?)
      game.start
    end

    it "ends if victory" do
      allow(board).to receive(:victory?).and_return(true)
      allow(board).to receive(:full?).and_return(false)
      expect(board).to receive(:victory?)
      game.start
    end
  end

=begin
  --private method tests--
  
  describe "#play_turn" do
    it "plays a turn and inserts a chip into the board" do
      board = game.instance_variable_get(:@board)
      player = game.instance_variable_get(:@player)
      expect(board).to receive(:show)
      allow(game).to receive(:input).and_return(4)
      game.play_turn
      arr = board.board
      expect(arr[4]).to eq([player, 'o', 'o', 'o', 'o', 'o'])
    end
  end

  describe "#input" do
    it "accepts player input and sets @choice variable" do
      expect(game).to receive(:print).with(instance_of(String))
      allow(game).to receive(:gets).and_return("4\n")
      expect(game.input).to eq(3)
    end
  end

  describe "#valid?" do
    context "checks if the input is valid when" do
      it "is between 1-7" do
        expect(game.valid?("4")).to eq(true)
      end

      it "is not between 1-7" do
        expect(game.valid?("8")).to eq(false)
      end

      it "is not a number" do
        expect(game.valid?("hey")).to eq(false)
      end
    end
  end
=end
end