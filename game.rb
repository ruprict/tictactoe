require './board'

module TicTacToe
  class Game
    attr_reader :board, :players, :current_player
    def initialize(board = Board.new)
      @board = board
      @players = [:X, :O]
      starting_player = @players.sample
      @players_enum = @players.cycle
      @current_player = @players_enum.next
      @current_player = @players_enum.next unless @current_player == starting_player
    end

      def play(row, col)
        @board[row,col] = @current_player
        @current_player = @players_enum.next
      end

    end
end

  require 'minitest/autorun'

  describe "Game" do
    before do
      @game = TicTacToe::Game.new
    end
    it "should start with an empty board" do
      @game.board.clear? 
  end
  it "should have two players" do
    @game.players.count == 2
  end
  it "should cycle players" do
    first = @game.current_player
    @game.play(1,1)
    refute(first == @game.current_player)
  end
end
