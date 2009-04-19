require 'test_helper'

class GameTest < ActiveSupport::TestCase
  context 'A game' do
    setup do
      @game = Game.new
      @cp = ComputerPlayer.new
      @hp = HumanPlayer.new
      @game.computer_players = [@cp]
      @game.human_player = @hp
    end
    should 'combine its computer players and human player' do
      assert_equal [@cp, @hp], @game.players
    end
  end
end
