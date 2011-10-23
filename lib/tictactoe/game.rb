require_relative 'board'

module TicTacToe
  class Game
    attr_reader :board, :players, :current_player, :winner
    def initialize(board = Board.new)
      @board = board
      @players = [:X, :O]
      starting_player = @players.sample
      @players_enum = @players.cycle
      @current_player = @players_enum.next
      @current_player = @players_enum.next unless @current_player == starting_player
      puts "#{@current_player} goes first."
    end

    def play(row, col)
      puts "Game is over" unless @winner.nil?
      @board[row,col] = @current_player
      current
      if (@board.has_winner?)
        puts "#{@current_player} is the winner!"
        @winner = @current_player
      else
        next_turn
      end
    end
   
    def current
      puts @board.current
      @board.current
    end

    def over?
      !@winner.nil?
    end
    private

    def next_turn
      @current_player = @players_enum.next
      puts "#{@current_player} is up."
    end
  end
end


