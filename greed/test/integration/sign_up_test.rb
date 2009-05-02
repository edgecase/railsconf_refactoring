require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class SignUpTest < ActionController::IntegrationTest
  pending_context 'When signing up for a game' do
    setup do
      visit "/"
    end

    context 'with a good name' do
      setup do
        fill_in "game_name", :with => "John"
        click_button "Next"
      end
      
      should 'go to the select players page' do
        assert_contain "Select the players"
      end
    end

    context 'with a bad name' do
      setup do
        fill_in "game_name", :with => ""
        click_button "Next"
      end
      
      should 'redisplay the signin page' do
        assert_contain "Your name:"
      end

      should 'display an error message' do
        assert_contain /name.*too.*short/i
      end
    end
  end
end

