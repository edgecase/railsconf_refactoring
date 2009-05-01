require 'test_helper'

class RollTest < ActiveSupport::TestCase
  context 'A Roll' do
    setup do
      @turn = Turn.new
      @roll = Roll.new(:turn => @turn)
    end

    context 'with several faces' do
      setup do
        @f2 = Face.new(:value => 2)
        @f3 = Face.new(:value => 3)
        @roll.faces = [@f2, @f3]
      end

      should 'know its faces' do
        assert_equal [@f2, @f3], @roll.faces
      end

      should 'know its turn' do
        assert_equal @turn, @roll.turn
      end

      should 'know its score' do
        
      end
    end
  end
end
