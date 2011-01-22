Feature: Link Viewing
  So that I can see links
  As a user of any type (anonymous or logged in)
  I can see links that others have posted

  Scenario: View latest links
    Given the following links exist:
      | title  | url                       | created_at |
      | Link 2 | http://www.carbonfive.com | 2011-01-02 |
      | Link 3 | http://www.carbonfive.com | 2011-01-03 |
      | Link 1 | http://www.carbonfive.com | 2011-01-01 |
     When I am on the home page
     Then I should see "Link 1"
      And I should see "Link 2"
      And I should see "Link 3"