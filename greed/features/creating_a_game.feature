Feature: Create a game
  As a user, 
  I would like to create a game,
  So that I can play greed against the computer

  Scenario: Default page 
    Given I go to the homepage
    Then I should see "Your Name"

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
    And I press "Play"
    Then I should see "Randy"
    And I should see "Connie"
    And I should see "John"

  Scenario: A Human Player Rolls Once
    Given the dice will roll 2,3,4,6,3
    And the dice will roll 1,2,5,4,3
    And I start a game
    When I take a turn
    Then the turn score so far is 150

  Scenario: A Human Player Rolls Once
    Given the dice will roll 2,3,4,6,3
    And the dice will roll 1,2,5,4,3
    And I start a game
    And I take a turn
    When I choose to hold
    Then John's game score is 150
    And it should be Connie's turn
