Feature: Link Posting
  So that others can see interesting links
  As a logged in user
  I can post a url and a title

  Scenario: Post a link
    Given the following users exist:
      | username  | password | password_confirmation |
      | mwynholds | password | password              |
    When I am logged in as "mwynholds" with password "password"
     And I am on the home page
     And I follow "Submit a Link"
     And I fill in "Title" with "title"
     And I fill in "Url" with "http://example.com"
     And I press "Submit"
    Then I should be on the home page
     And I should see "Thanks for your link!"
