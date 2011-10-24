require 'pry'
module TicTacToe
  class Board
    LEFT_DIAGONAL_POSITIONS  = [[0,0],[1,1],[2,2]]
    RIGHT_DIAGONAL_POSITIONS = [[2,0],[1,1],[0,2]]
    attr_reader :surface
    def initialize
      initialize_surface
    end
   
    def rows
      [@surface[0],@surface[1],@surface[2] ] 
    end

    def cols
      col1 = []
      col2 = []
      col3 = []
      @surface.each do |row|
        row.each_with_index do |cell,index|
          if index == 0
            col1 << cell 
          elsif index == 2
            col3 << cell
          else
            col2 << cell
          end
        end
      end
      [col1,col2,col3]
    end

    def [](x,y)
      @surface[x][y]
    end

    def []=(*args)
      x, y = args.slice(0), args.slice(1)
      raise IndexError.new unless (x < 3 && y < 3)
      raise CellAlreadyPlayedError unless @surface[x][y].nil?
      @surface[x][y] = args.last
      @clear = false
    end
    
    def clear?
      @clear
    end
    # Display the current board in a 
    # tictactoey fashion
    def current
      str = ""
      @surface.each do |row|
        row.each_with_index do |cell, ind|
          str << (cell.nil? ? " " : cell.to_s) 
          str << "|" unless ind == 2
        end
        str << "\n"
      end
      str
    end

    def has_winner?
      winner = false
      [rows].each do |row|
        row.each do |cells|
          if cells.all? {|c| c == :X} || cells.all? {|c| c == :O}
            winner = true
            break
          end
        end
      end
      [cols, left_diagonal, right_diagonal].each do |row|
        if row.all? {|c| c == :X} || row.all? {|c| c == :O}
          winner = true
          break
        end
      end
      winner
    end

    def left_diagonal
      LEFT_DIAGONAL_POSITIONS.map { |e| self[*e] }
    end
    def right_diagonal
      RIGHT_DIAGONAL_POSITIONS.map{|e| self[*e]} 
    end
    private

    def initialize_surface
      @surface = [[nil,nil,nil],
               [nil,nil,nil], 
               [nil,nil,nil]]

      @clear = true
    end
  end

  class CellAlreadyPlayedError < StandardError; end
end


