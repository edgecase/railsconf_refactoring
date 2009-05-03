require 'test_helper'

class HumanPlayerTest < ActiveSupport::TestCase
  context 'A human player' do
    setup do
      @player = HumanPlayer.new
    end

    context 'when starting a turn' do
      setup do
        @player.start_turn
      end
      
      should 'add a turn' do
        assert_equal 1, @player.turns.size
      end

      context 'and rolling the dice' do
        setup do
          @player.roll_dice
        end
        should 'have one roll on the last turn' do
          assert_equal 1, @player.last_turn.rolls.size
        end
      end
    end
  end
end
