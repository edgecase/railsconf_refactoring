require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  context 'A Turn' do
    setup do
      @player = ComputerPlayer.new
      @turn = Turn.new
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
