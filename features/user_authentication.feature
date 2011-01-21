Feature: User authentication
  So that I can access the site
  As a user with an account
  I can log in and log out of the site

  Scenario: Log in
    Given the following user exists:
      | username  | password | password_confirmation |
      | mwynholds | password | password              |
     When I go to the login page
      And I fill in "Username" with "mwynholds"
      And I fill in "Password" with "password"
      And I press "Login"
     Then I should be on the home page
      And I should see "Logout"
      And I should not see "Login"

  Scenario: Log out
    Given the following user exists:
      | username  | password | password_confirmation |
      | mwynholds | password | password              |
    When I am logged in as "mwynholds" with password "password"
     And I follow "Logout"
    Then I should be on the home page
     And I should not see "Logout"
     And I should see "Login"
     And I should see "Register"