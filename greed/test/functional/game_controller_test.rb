require 'test_helper'


class GameControllerTest < ActionController::TestCase
  def post_create
    post :create, :player => { :name => "Bob" }
  end

  context "Action Create" do
    setup do
      @game = new_game
      @player = HumanPlayer.new
      flexmock(HumanPlayer).should_receive(:create).
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
    end

    context 'with no players' do
      setup { post_assign_players([]) }

      should 'redirect to back to choose players' do
        assert_redirected_to choose_players_game_path
      end

      should 'have a need players notice' do
        assert_match(/select.*player/, flash[:error])
      end
    end

    context 'with some players' do
      setup { post_assign_players(["Randy", "Connie"]) }
      
      should 'redirect to auto_turn' do
        assert_redirected_to computer_turn_game_path(@game)
      end
      
      should 'assign the players to the game' do
        assert_equal ["Randy", "Connie"], @game.computer_players.map(&:strategy)
      end
    end    

    context 'with some players already defined' do
      setup do
        @game.computer_players = [ ComputerPlayer.new(:strategy => "Randy") ]
        post_assign_players(["Connie"])
      end
      should 'drop the previously defined players in favor of the new' do
        assert_equal ["Connie"], @game.computer_players.map(&:strategy)
      end
    end
  end
  
  private

  def post_assign_players(players)
    post :assign_players,
      :id => @game.id,
      :players => players
  end

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
