Feature: Link Viewing
  So that I can see links
  As a user of any type (anonymous or logged in)
  I can see links that others have posted

  Scenario: View latest links
    Given the following links exist:
      | id | title  | url                       | author_id | created_at |
      | 2  | Link 2 | http://www.carbonfive.com | 1         | 2011-01-02 |
      | 3  | Link 3 | http://www.carbonfive.com | 1         | 2011-01-03 |
      | 1  | Link 1 | http://www.carbonfive.com | 2         | 2011-01-01 |
      And the following users exist:
      | id | username | password |
      | 1  | user1    | password |
      | 2  | user2    | password |
     When I am on the home page
     Then I should see "Link 1" within "#link-1"
      And I should see "submitted by user2" within "#link-1"
      And I should see "Link 2" within "#link-2"
      And I should see "submitted by user1" within "#link-2"
      And I should see "Link 3" within "#link-3"
      And I should see "submitted by user1" within "#link-3"