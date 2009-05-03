require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  context 'A Turn' do
    setup do
      @turn = Turn.new
      @player = ComputerPlayer.new(:turns => [@turn])
      @player.save
    end

    should 'know its player' do
      assert_equal @player, @turn.player
    end

    context 'with several rolls' do
      setup do
        @r1 = Roll.new
        @r2 = Roll.new
        @turn.rolls = [@r1, @r2]
      end

      should 'know its rolls' do
        assert_equal [@r1, @r2], @turn.rolls
      end
    end
  end
end
