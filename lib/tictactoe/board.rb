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
      @surface
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
      @surface.each do |row|
        if row.all? {|c| c == :X} || row.all? {|c| c == :O}
          winner = true
        end
      end
      cols.each do |col|
        if col.all? {|c| c == :X} || col.all?{|c| c == :O}
          winner = true
        end
      end
      if left_diagonal.all? {|c| c == :X} || left_diagonal.all?{|c| c == :O}
        winner = true
      end
      if right_diagonal.all? {|c| c == :X} || right_diagonal.all?{|c| c == :O}
        winner = true
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


