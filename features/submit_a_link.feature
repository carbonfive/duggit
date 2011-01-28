Feature: Submit a link
  In order to share interesting links
  As a user
  I can submit a link

  Scenario: Submit a link
    Given I am registered user
    When I go to the registration page
     And I fill in "Username" with "mwynholds"
     And I fill in "Password" with "password"
     And I fill in "Confirm" with "password"
     And I press "Register"
    Then I should be on the home page 
     And I should see "Welcome mwynholds"
    When I go to the home page
     And I follow "Submit a Link"
     And I fill in "Title" with "title"
     And I fill in "Url" with "http://example.com"
     And I press "Submit"
    Then I should be on the home page
     And I should see "Thanks for your link!"
