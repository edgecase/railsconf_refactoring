require 'test_helper'


class GameControllerTest < ActionController::TestCase
  def post_create
    post :create, :player => { :name => "Bob" }
  end

  context "Action Create" do
    setup do
      @game = Game.new
      flexmock(Game).should_receive(:create).with().once.
        and_return(@game)
      flexmock(@game).should_receive(:id).and_return(123)
      @player = Player.new
      flexmock(Player).should_receive(:create).
        with("name" => "Bob").once.
        and_return(@player)
    end

    context 'when the save worked' do
      setup do
        flexmock(@game).should_receive(:save).once.and_return(true)
        post_create
      end
      
      should 'assign the game' do
        assert_equal @game, assigns(:game)
      end
      
      should 'get a player' do
        assert_equal @player, assigns(:game).web_player
      end
      
      should 'redirect to add player' do
        assert_redirected_to :action => "add_players", :id => @game.id
      end
      
      should 'place the game id in the session' do
        assert_equal @game.id, session[:game]
      end
    end

    context 'when the save failed' do
      setup do
        flexmock(@game).should_receive(:save).once.and_return(false)
        post_create
      end

      should 'redirect to new' do
        assert_redirected_to :action => "new"
      end
      
      should 'have an error message' do
        assert_equal "Can not create game", flash[:error]
      end
    end
  end
end
