Feature: Browsing links
  In order to find interesting links 
  As a visitor or a registered user
  I can see links that users have submitted

  Scenario: Browse latest links
    Given the following links exist:
      | title  | created_at |
      | Link 1 | 2011-01-01 |
      | Link 2 | 2011-01-02 |
      | Link 3 | 2011-01-03 |
    When I go to the home page
    Then I should see the following links in order:
      | title  |
      | Link 3 |
      | Link 2 |
      | Link 1 |
