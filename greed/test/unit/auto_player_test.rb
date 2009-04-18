require 'test_helper'

class AutoPlayerTest < Test::Unit::TestCase
  Named = Struct.new(:name)

  context 'An AutoPlayer' do
    context 'with registering players' do
      setup do
        @joe = Named.new("Joe")
        @bob = Named.new("Bob")
        AutoPlayer.register(@joe)
        AutoPlayer.register(@bob)
      end

      should 'report the registered players' do
        assert_equal [@joe, @bob], AutoPlayer.players
      end

      should 'find individual players' do
        assert_equal @joe, AutoPlayer["Joe"]
      end

      context 'and cleared registry' do
        setup do
          AutoPlayer.clear
        end
        should 'be empty' do
          assert AutoPlayer.players.empty?, "should be empty"
        end
      end
    end
  end
end
