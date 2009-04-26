Then /^I am asked to choose players$/ do
  response.should contain("Select the players")
end

Given /^I start a game$/ do 
  visit path_to("the homepage")
  fill_in("game_name", :with => "John") 
  click_button("Next")
  check("Randy")
  click_button("Play")
end

