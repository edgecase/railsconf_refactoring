require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  context 'A player' do
    should 'can be created' do
      assert_not_nil Player.new
    end
  end
end
