require 'test_helper'

class HumanPlayerTest < ActiveSupport::TestCase
  context 'A human player' do
    setup do
      @data = []
      @roller = Roller.new(SimulatedData.new(@data))
      @player = HumanPlayer.new
      @player.roller = @roller
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
          @data << [1,2,3,4,5]
          @player.roll_dice
        end

        should 'have one roll on the last turn' do
          assert_equal 1, @player.last_turn.rolls.size
        end

        should 'have a turn score matching the roll' do
          assert_equal 150, @player.last_turn.score
        end

        context 'and holding' do
          setup do
            @player.holds
          end
          should 'have the turn score added to the total score' do
            assert_equal 150, @player.score
          end
        end
      end
    end
  end
end
