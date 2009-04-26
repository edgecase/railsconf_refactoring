require 'test_helper'

class GameControllerTest < ActionController::TestCase
  def post_create
    post :create, :game => { :name => "Bob" }
  end

  # ------------------------------------------------------------------

  context "Action Create" do
    setup do
      @player = new_player
      @game = new_game(@player)
    end

    context 'when the save worked' do
      setup do
        flexmock(@game).should_receive(:save).and_return(true)
        flexmock(@player).should_receive(:save).and_return(true)
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
        flexmock(@game).should_receive(:save).and_return(false)
        flexmock(@player).should_receive(:save).and_return(false)
        post_create
      end

      should 'redirect to new' do
        assert_redirected_to new_game_path
      end
      
      should 'have an error message' do
        assert_match /Can not create game/, flash[:error]
      end
    end
  end

  # ------------------------------------------------------------------

  context 'Action choose_players' do
    setup do
      @game = existing_game
      @game.human_player = HumanPlayer.new(:name => "Bob")
      get :choose_players, :id => @game.id
    end

    should 'assign the game' do
      assert_equal @game, assigns(:game)
    end
  end

  # ------------------------------------------------------------------

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

  # ------------------------------------------------------------------  

  context 'Action computer_turn' do
    setup do
      @c1 = ComputerPlayer.new(:score => 50)
      @c2 = ComputerPlayer.new
      @c1.logic = dummy_logic
      @c2.logic = dummy_logic
      @game = existing_game
      @game.computer_players = [@c1, @c2]
      @game.human_player = HumanPlayer.new
    end

    context 'with a two player game' do
      setup do
        flexmock(@c1).should_receive(:take_turn).once.and_return(fake_turn_data(@c1))
        flexmock(@c2).should_receive(:take_turn).once.and_return(fake_turn_data(@c2))
        flexmock(@c1).should_receive(:save).once.and_return(true)
        flexmock(@c2).should_receive(:save).once.and_return(true)

        get :computer_turn, :id => @game.id
      end

      should 'let all the computer players take a turn' do
        # assertions in mocks
      end

      should 'return the turn histories' do
        assert_equal [fake_turn_data(@c1), fake_turn_data(@c2)],
          assigns(:turn_histories)
      end

      should 'add the turn scores to the players' do
        assert_equal 250, @c1.score
      end
    end
  end

  # ------------------------------------------------------------------  

  context 'Action human_turn' do
    setup do
      @game = existing_game
      @game.human_player = HumanPlayer.new
    end

    should 'have a game and a roll' do
      get :human_turn, :id => @game.id

      assert_not_nil assigns(:game)
      assert_not_nil assigns(:roll_data)
    end
  end
  
  private

  def post_assign_players(players)
    post :assign_players,
      :id => @game.id,
      :players => players
  end
  
  def new_player
    player = HumanPlayer.new
    flexmock(HumanPlayer).should_receive(:create).
      with("name" => "Bob").once.
      and_return(player)
    player
  end

  def new_game(player)
    game = Game.new(:human_player => player)
    flexmock(game).should_receive(:id).and_return(123)
    flexmock(Game).should_receive(:create).once.
      with(:human_player => player).
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

  def dummy_logic
    flexmock("logic",
      :name => "Dummy",
      :description => "Dummy Logic",
      :roll_again? => false)
  end

  def fake_turn_data(cp)
    @fake_turn_data ||= TurnData.new(cp, 200, [])
  end
end
