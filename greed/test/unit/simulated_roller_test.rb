require 'test_helper'

class SimulatedRollerTest < Test::Unit::TestCase
  context 'An simulated roller' do
    setup do
      @sim_data = []
      @roller = SimulatedRoller.new(@sim_data)
    end

    context 'with no data' do
      should 'roll empty rolls' do
        @roller.roll(4)
        assert_equal [], @roller.faces
      end
    end

    context 'with data' do
      setup do
        @expected_data = [[1,1,1,1,1], [2,2,2,2,2], [3,3,3,3,3]]
        @expected_data.each do |roll| @sim_data.push(roll) end
      end

      should 'return the rolls in orderr' do
        result = (1..3).map { |i|
          @roller.roll(5)
          @roller.faces
        }
        assert_equal @expected_data, result
      end

      should 'honor the requested number of dice' do
        @roller.roll(2)
        assert_equal [1,1], @roller.faces
      end
    end

  end
end
