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
      return unless can_play?
      begin
        play_board(row, col)
      rescue TicTacToe::CellAlreadyPlayedError
        puts "Cell taken, try again"
        current
        return
      end
      if (board.has_winner?)
        @winner = @current_player
        current
        can_play?
        
      else
        current
        next_turn
      end
    end
  
    def can_play?
      if board.has_winner?
        p "Game is over. #{@winner} won."
        false
      else
        true
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
    
    def play_board(row, col)
      @board[row,col] = @current_player
    end
  end
end


