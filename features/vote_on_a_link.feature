Feature: Vote on a link
  In order to voice my opinion of links
  As a user
  I can vote on other user's links 

  Background:
    Given the following links exist:
      | id | title  | url                       | author_id | created_at |
      | 1  | Link 1 | http://www.carbonfive.com | 1         | 2011-01-01 |
      And the following users exist:
      | id | username | password |
      | 1  | user1    | password |
      | 2  | user2    | password |

  Scenario: Vote up a link
    Given I am logged in as "user2"
     When I am on the home page
      And I vote "up" for link 1
     Then I should be on the home page
      And I should not be able to up-vote for link 1
      And I should be able to down-vote for link 1
      And I should see "1" as the value for link 1

  Scenario: Vote down a link
    Given I am logged in as "user2"
     When I am on the home page
      And I vote "down" for link 1
     Then I should be on the home page
      And I should see "-1" as the value for link 1
      And I should be able to up-vote for link 1
      But I should not be able to down-vote for link 1

  Scenario: Try to vote on my own link
    Given I am logged in as "user1"
     When I am on the home page
     Then I should not be able to up-vote for link 1
      And I should not be able to down-vote for link 1
      And I should see "0" as the value for link 1
