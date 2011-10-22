require 'board'
require_relative "../lib/game"

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


