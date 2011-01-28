Feature: Browsing links
  In order to find interesting links 
  As a visitor or a registered user
  I can see links that users have submitted

  Background:
    Given the following users exist:
      | username   | password |
      | userone    | password |
      | usertwo    | password |
      And the following links exist:
        | title  | url                  | author_id | created_at |
        | Link 1 | http://example.com/1 | 2         | 2011-01-01 |
        | Link 2 | http://example.com/2 | 1         | 2011-01-02 |
        | Link 3 | http://example.com/3 | 1         | 2011-01-03 |
      And the following votes exist:
        | user_id           | link_id       | value |
        | username: userone | title: Link 1 | 1     |
        | username: userone | title: Link 2 | -1    |
        | username: usertwo | title: Link 2 | -1    |
        | username: usertwo | title: Link 3 | 1     |
        | username: usertwo | title: Link 1 | -1    |

  Scenario: Browse latest links
    When I go to the home page
    Then I should see the links in the following order:
      | title  | url                  | submitter   | votes  |
      | Link 3 | http://example.com/3 | usertwo     | 1      |
      | Link 2 | http://example.com/2 | userone     | -2     |
      | Link 1 | http://example.com/1 | userone     | 0      |

  Scenario: Logged in user can vote 
    Given I am logged in as "usertwo"
     When I go to the home page
     Then I should be able to up-vote for link 1
      And I should be able to down-vote for link 1
      And I should see "0" as the value for link 1

  Scenario: Visitors can NOT vote
     When I go to the home page
     Then I should not be able to up-vote for link 1
      And I should not be able to down-vote for link 1
      And I should see "0" as the value for link 1
