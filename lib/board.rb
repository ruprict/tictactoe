require 'pry'
module TicTacToe
  class Board
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


