require_relative './test_helper'

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

  it "should display the board" do
    @game.current.must_equal(" | | \n | | \n | | \n")
  end

  it "should say who is first" do
    skip("can't figure out how to assert_output...")
    proc {
      TicTacToe::Game.new
    }.must_output(/is first/)
  end

  it "should declare a winner" do
    first = @game.current_player
    @game.play(0,0)
    @game.play(0,2)
    @game.play(1,1)
    @game.play(1,2)
    @game.play(2,2)

    @game.winner.must_equal(first)
    assert(@game.over?)
  end

  it "should handle a cell already played" do
    skip("Need to test output again...") 
  end
end
