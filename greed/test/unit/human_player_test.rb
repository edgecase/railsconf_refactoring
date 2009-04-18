require 'test_helper'

class HumanPlayerTest < ActiveSupport::TestCase
  context 'A player' do
    should 'can be created' do
      assert_not_nil HumanPlayer.new
    end
  end
end
