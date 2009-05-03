require 'test_helper'

class HumanPlayerTest < ActiveSupport::TestCase
  context 'A human player' do
    setup do
      @data = []
      @roller = Roller.new(SimulatedData.new(@data))
      @player = HumanPlayer.new
      @player.roller = @roller
    end

    context 'when taking a turn' do
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

        context 'and rolls again' do
          setup do
            @data << [1,1,1,1,1]
            @player.rolls_again
          end
          should 'have 2 rolls' do
            assert_equal 2, @player.last_turn.rolls.size
          end
          should 'have the first roll have the roll action' do
            assert_equal :roll, @player.last_turn.rolls[0].action
          end
          should 'have the second roll with only unused dice' do
            assert_equal 3, @player.last_turn.rolls.last.face_values.size
          end

          context 'and rolls yet again' do
            setup do
              @data << [1,2,3,4,5]
              @player.rolls_again
            end
            should 'roll all 5 dice' do
              assert_equal 5, @player.last_turn.rolls.last.face_values.size
            end
          end
        end
      end
    end
  end
end
