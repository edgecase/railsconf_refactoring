require 'test_helper'


class GamesControllerTest < ActionController::TestCase

  context "Action Create" do

    context 'when no players have been chosen' do
      setup do
        post :create, :game => {:name => "Josh" }
      end
   
      should "redirect to choose_players" do
        assert_redirected_to choose_players_game_path(0)
      end
    end
    
    context "when players have been chosen" do
      setup do
        post :create, :game => {:name => "Josh" , :players => [1,2]}
      end
   
      should "redirect to choose_players" do
        assert_response :success
      end
    end
  end
end