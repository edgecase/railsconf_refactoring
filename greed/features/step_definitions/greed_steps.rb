Then /^I am asked to choose players$/ do
  response.should contain("Select Your Opponents")
end

Given /^the dice will roll ([1-6,]+)$/ do |faces|
  f = faces.split(",").map { |n| n.to_i }.join("-")
  visit "/simulate/#{f}"
end

Given /^I take a turn$/ do
  click_link("Start Your Turn")
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

Then /^the turn score so far is (\d+)$/ do |score|
  assert_contain "so far: #{score}"
end

When /^I choose to hold$/ do
  click_link "Hold"
end

Then /^(\w+)'s game score is (\d+)$/ do |player, score| # '
  doc = Nokogiri::HTML(response.body)
  n = doc.css("div#sidebar")
  assert_match(/#{player}\s+#{score}/, n.text)
end
