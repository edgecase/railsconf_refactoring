require 'test_helper'

class GameTest < ActiveSupport::TestCase
  context 'A game' do
    should 'be created' do
      assert_not_nil Game.new      
    end
  end
end
