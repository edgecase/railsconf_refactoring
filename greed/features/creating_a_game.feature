Feature: Create a game
  As a user, 
  I would like to create a game,
  So that I can play greed against the computer

  Scenario: Default page 
    Given I go to the homepage
    Then I should see "Your name:"

  Scenario: Adding players to a page
    Given I go to the homepage
    When I fill in "game_name" with "John"
    And I press "Next"
    Then I am asked to choose players
    
  Scenario: Creating the game as a whole
    Given I go to the homepage
    When I fill in "game_name" with "John"
    And I press "Next"
    And I check "Randy"
    And I check "Connie"
    Then I should see "Randy"
    And I should see "Connie"
    And I should see "John"