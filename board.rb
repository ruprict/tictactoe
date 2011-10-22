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

require 'minitest/autorun'
describe "Board" do
  before do
    @board = TicTacToe::Board.new
  end
  it "should have a 3 X 3 structure" do
    @board.rows.count.must_equal(3)
    @board.cols.count.must_equal(3)
  end
  it "should allow setting row, col values" do
    @board[1,1] = :X
    @board[1,1].must_equal(:X)
    @board[2,2] = :O
    @board[2,2].must_equal(:O)
  end

  it "must not allow setting row,col outside grid" do
    assert_raises(IndexError) { @board[4,1] = :X }
    assert_raises(IndexError) { @board[1,4] = :X }
  end
  
  it "should return a column value if set" do
    @board[2,1] = :X
    @board.cols[1][2].must_equal(:X)
  end

  it "should be clear at first" do
    assert(@board.clear?)
  end

  it "should not be clear if a cell has a value" do
    @board[1,1] = :X
    refute(@board.clear?, "Board is not clear")
  end

  it "should not let the same cell be played twice" do
    @board[1,1] = :O
    assert_raises(TicTacToe::CellAlreadyPlayedError) {@board[1,1] = :X}
  end
end
