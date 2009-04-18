require 'test_helper'


class GameControllerTest < ActionController::TestCase
  def post_create
    post :create, :player => { :name => "Bob" }
  end

  context "Action Create" do
    setup do
      @game = new_game
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
        assert_equal @player, assigns(:game).human_player
      end
      
      should 'redirect to add player' do
        assert_redirected_to choose_players_game_path(@game)
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
        assert_redirected_to new_game_path
      end
      
      should 'have an error message' do
        assert_equal "Can not create game", flash[:error]
      end
    end
  end

  context 'Action choose_players' do
    setup do
      @game = existing_game
      get :choose_players, :id => @game.id
    end

    should 'assign the game' do
      assert_equal @game, assigns(:game)
    end
  end

  context 'Action assign_players' do
    setup do
      @game = existing_game
      post :assign_players,
        :id => @game.id,
        :players => ["Joe", "Connie"]
    end

    should 'redirect to auto_turn' do
      assert_redirected_to auto_turn_game_path(@game)
    end

    should 'assign the players to the game' do
#      assert_equal [Randy, Connie], @game.players
    end
    
  end

  private

  def new_game
    game = Game.new
    flexmock(game).should_receive(:id).and_return(123)
    flexmock(Game).should_receive(:create).with().once.
      and_return(game)
    game
  end

  def existing_game
    game = Game.new
    flexmock(game).should_receive(:id).and_return(123)
    flexmock(Game).should_receive(:find).with(/^#{game.id}$/).
      and_return(game)
    game
  end
end
