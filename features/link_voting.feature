Feature: Link Voting
  So that I can give feedback on quality of links
  As a logged in user
  I can up- or down-vote other people's links (one time only)

  Background:
    Given the following links exist:
      | id | title  | url                       | author_id | created_at |
      | 1  | Link 1 | http://www.carbonfive.com | 1         | 2011-01-01 |
      And the following users exist:
      | id | username | password |
      | 1  | user1    | password |
      | 2  | user2    | password |

  Scenario: Anonymous user cannot vote
     When I am on the home page
     Then I should not be able to up-vote for link 1
      And I should not be able to down-vote for link 1
      And I should see "0" as the value for link 1

  Scenario: Logged in user can vote
    Given I am logged in as "user2"
     When I am on the home page
     Then I should be able to up-vote for link 1
      And I should be able to down-vote for link 1
      And I should see "0" as the value for link 1

  Scenario: Logged in user cannot vote for own links
    Given I am logged in as "user1"
     When I am on the home page
     Then I should not be able to up-vote for link 1
      And I should not be able to down-vote for link 1
      And I should see "0" as the value for link 1

  Scenario: Logged in user only gets one vote per link
    Given I am logged in as "user2"
     When I am on the home page
      And I vote "up" for link 1
     Then I should be on the home page
      And I should not be able to up-vote for link 1
      And I should be able to down-vote for link 1
      And I should see "1" as the value for link 1

