require_relative './test_helper'
require_relative '../lib/game'

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
