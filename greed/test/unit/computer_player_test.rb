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

  context 'A Computer Player' do
    setup do
      @player = ComputerPlayer.new
      @player.logic = @strategy
    end
    
    context 'where the player goes bust on first roll' do
      setup do
        flexmock(@player.roller).should_receive(:random_faces).with(5).
          once.and_return([4,2,2,3,3])
        flexmock(@player).should_receive(:roll_again?).never
      end
      
      should "get the points of the roll" do
        assert_equal [0, [RollData.new([4,2,2,3,3], 0, 0, 5, :bust)]],
          @player.take_turn
      end
    end
    
    context 'where the player holds on first roll' do
      setup do
        flexmock(@player.roller).should_receive(:random_faces).with(5).
          once.and_return([1,2,2,3,3])
        flexmock(@player).should_receive(:roll_again?).once.
          and_return(false)
      end
      
      should "get the points of the roll" do
        assert_equal [100, [RollData.new([1,2,2,3,3], 100, 100, 4, :hold)]],
          @player.take_turn
      end
    end
    
    context 'where the player rolls again' do
      setup do
        flexmock(@player.roller).should_receive(:random_faces).with(5).
          once.and_return([1,2,2,3,3])
        flexmock(@player).should_receive(:roll_again?).once.
          and_return(true)
      end
      
      context 'and then holds' do
        setup do
          flexmock(@player.roller).should_receive(:random_faces).with(4).
            once.and_return([5,2,3,3])
          flexmock(@player).should_receive(:roll_again?).once.
            and_return(false)
        end
        
        should 'get the total points of the turn' do
          assert_equal [150,
            [
              RollData.new([1,2,2,3,3], 100, 100, 4, :roll),
              RollData.new([5,2,3,3], 150, 50, 3, :hold),
            ]
          ], @player.take_turn
        end
      end
      
      context 'and goes bust' do
        setup do
          flexmock(@player.roller).should_receive(:random_faces).with(4).
            once.and_return([4,2,3,3])
          flexmock(@player).should_receive(:roll_again?).never
        end
        
        should 'get zero points for that turn' do
          assert_equal  [0,
            [
              RollData.new([1,2,2,3,3], 100, 100, 4, :roll),
              RollData.new([4,2,3,3], 0, 0, 4, :bust),
            ]
          ], @player.take_turn
        end
      end
    end
  end
end
