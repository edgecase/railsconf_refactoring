require 'test_helper'

class ComputerPlayerTest < ActiveSupport::TestCase
  context 'A Computer Player' do
    setup do
      @player = ComputerPlayer.new(:strategy => "Randy")
    end
    should 'create their strategy' do
      assert_instance_of Randy, @player.logic
    end
  end
end
