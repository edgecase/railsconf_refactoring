Then /^I am asked to choose players$/ do
  response.should contain("Select Your Opponents")
end

Given /^I start a game$/ do 
  $roller = nil
  visit path_to("the homepage")
  fill_in("game_name", :with => "John") 
  click_button("Next")
  check("Connie")
  click_button("Play")
end

Given /^I look at the total score for (\w+)$/ do |player|
  doc = Nokogiri::HTML(response.body)
  n = doc.css("span.score")
  @saved_total_points = n.first.text
end

When /^I refresh the screen$/ do
  visit request.path
end

Then /^the total score for Connie is unchanged$/ do
  doc = Nokogiri::HTML(response.body)
  n = doc.css("span.score")
  assert_equal @saved_total_points, n.first.text
end
