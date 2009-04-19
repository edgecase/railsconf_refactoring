require 'test_helper'

class ComputerPlayerTest < ActiveSupport::TestCase
  context 'A Computer Player' do
    setup do
      @player = ComputerPlayer.new(:strategy => "Randy")
    end
    should 'create their strategy' do
      assert_instance_of Randy, @player.logic
    end

    context 'with a strategy' do
      setup do
        @strategy = flexmock("Strategy")
        @player.instance_variable_set("@logic", @strategy)
      end
      should 'delegate name' do
        @strategy.should_receive(:name).once
        @player.name
      end
      should 'delegate description' do
        @strategy.should_receive(:description).once
        @player.description
      end
      should 'delegate roll_again?' do
        @strategy.should_receive(:roll_again?).once
        @player.roll_again?
      end
    end
  end
end
