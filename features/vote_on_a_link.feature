Feature: Vote on a link
  In order to voice my opinion of links
  As a user
  I can vote on other user's links 

  Background:
    Given the following users exist:
      | username   | password |
      | userone    | password |
      | usertwo    | password |
      And the following links exist:
        | title  | user              |
        | Link 1 | username: userone |
        | Link 2 | username: usertwo |

  Scenario: Vote up a link
    Given I am logged in as "usertwo/password"
     When I go to the home page
      And I vote up "Link 1"
     Then I should be on the home page
      And I should not see "Unable to tally your vote"
      And I should see "1" as the value for "Link 1"
      And I should be able to down-vote "Link 1"

  Scenario: Vote down a link
    Given I am logged in as "usertwo/password"
     When I go to the home page
      And I vote down "Link 1"
     Then I should be on the home page
      And I should see "-1" as the value for "Link 1"
      And I should be able to up-vote "Link 1"

  Scenario: Change your vote on a link
    Given I am logged in as "usertwo/password"
     When I go to the home page
      And I vote down "Link 1"
     Then I should see "-1" as the value for "Link 1"
     When I vote up "Link 1" 
     Then I should see "1" as the value for "Link 1"

  Scenario: Try to vote on your own link
    Given I am logged in as "userone/password"
     When I go to the home page
     Then I should not be able to up-vote "Link 1"
      And I should not be able to down-vote "Link 1"

  Scenario: Try to vote when not logged in
     When I go to the home page
     Then I should not be able to up-vote "Link 1"
      And I should not be able to down-vote "Link 1"
