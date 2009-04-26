require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class ChoosePlayersTest < ActionController::IntegrationTest
  context 'When choosing players for a game' do
    setup do
      @human = HumanPlayer.new(:name => "John")
      @game = Game.create!(:human_player => @human)
      visit choose_players_game_path(@game)
    end
    
    should 'welcome the player' do
      assert_contain /Welcome.*John/
    end
      
    should 'offer several players' do
      assert_contain "Randy"
      assert_contain "Connie"
      assert_contain "Aggie"
    end

    context 'and selecting a player' do
      setup do
        check "Randy"
        click_button "Play"
      end
      should 'go to the next page' do
        assert_contain /Randy's Turn/ # '
      end
    end

    context 'but selecting no player' do
      setup do
        click_button "Play"
      end
      should 'stay on the same page' do
        assert_contain "Welcome"
      end
      should 'prompt for a player selection' do
        assert_contain /please.*select/i
      end
    end
  end
end
